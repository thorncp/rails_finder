require "spec_helper"
require "rails_finder"
require "tmpdir"
require "fileutils"

LEGIT_GEMFILE = <<END
source :rubygems

gem 'rails', '3.2.11'
gem 'jquery-rails'
gem 'sqlite3'

group :development, :test do
  gem 'rspec', '~> 2.12'
end
END

VALID_2_3_ENVIRONMENT_FILE = <<END
RAILS_GEM_VERSION = '2.3.16' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'Pacific Time (US & Canada)'
	config.cache_store = :mem_cache_store
end
END

VALID_ISOLATE_FILE = <<END
options :system => false

gem 'rails', '3.0.20', :require => 'rails'
gem 'oauth'
gem 'mysql2', '0.2.18'
END

describe RailsFinder do
  it "finds and reports on valid Gemfile" do
    Dir.mktmpdir "rails_finder-valid_app" do |dir|
      FileUtils.mkdir_p(File.join(dir, "config"))
      FileUtils.touch(File.join(dir, "config", "environment.rb"))
      File.open(File.join(dir, "Gemfile"), "w") do |file|
        file.puts(LEGIT_GEMFILE)
      end

      out = StringIO.new
      RailsFinder.run(dir, out)
      out.string.should include "3.2.11"
      out.string.should include "rails_finder-valid_app"
    end
  end

  it "finds and reports on valid 2.3 environment file" do
    Dir.mktmpdir "valid_2.3_app" do |dir|
      FileUtils.mkdir_p(File.join(dir, "config"))
      File.open(File.join(dir, "config", "environment.rb"), "w") do |file|
        file.puts(VALID_2_3_ENVIRONMENT_FILE)
      end

      out = StringIO.new
      RailsFinder.run(dir, out)
      out.string.should include "2.3.16"
      out.string.should include "valid_2.3_app"
    end
  end

  it "finds and reports on valid Isolate file" do
    Dir.mktmpdir "valid_app_with_isolate" do |dir|
      FileUtils.mkdir_p(File.join(dir, "config"))
      FileUtils.touch(File.join(dir, "config", "environment.rb"))
      File.open(File.join(dir, "Isolate"), "w") do |file|
        file.puts(VALID_ISOLATE_FILE)
      end

      out = StringIO.new
      RailsFinder.run(dir, out)
      out.string.should include "3.0.20"
      out.string.should include "valid_app_with_isolate"
    end
  end
end
