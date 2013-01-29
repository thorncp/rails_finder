require "spec_helper"
require "rails_finder/environment_file"
require "tmpdir"
require "fileutils"

VALID_ENVFILE = <<END
RAILS_GEM_VERSION = '2.3.16' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'Pacific Time (US & Canada)'
	config.cache_store = :mem_cache_store
end
END


module RailsFinder
  describe EnvironmentFile do
    it "knows if file exists" do
      with_dir do |dir|
        FileUtils.touch(envfile(dir))
        EnvironmentFile.new(envfile(dir)).should exist
      end
    end

    it "knows if file does not exist" do
      with_dir do |dir|
        EnvironmentFile.new(envfile(dir)).should_not exist
      end
    end

    it "reports Rails version" do
      with_dir do |dir|
        File.open(envfile(dir), "w") do |file|
          file.puts(VALID_ENVFILE)
        end

        EnvironmentFile.new(envfile(dir)).rails_version.should == "2.3.16"
      end
    end

    it "reports none when no Rails version" do
      with_dir do |dir|
        File.open(envfile(dir), "w") do |file|
          file.puts "require File.expand_path('../application', __FILE__)"
          file.puts "Recipes::Application.initialize!"
        end

        EnvironmentFile.new(envfile(dir)).rails_version.should == "n/a"
      end
    end

    it "memoizes rails version" do
      with_dir do |dir|
        File.open(envfile(dir), "w") do |file|
          file.puts(VALID_ENVFILE)
        end

        @subject = EnvironmentFile.new(envfile(dir))
        @subject.rails_version.should == "2.3.16"
      end

      @subject.rails_version.should == "2.3.16"
    end
  end
end
