require "rails_finder"
require "fileutils"

RSpec.configure do |config|
  def with_dir
    Dir.mktmpdir("rails_version-spec") do |dir|
      FileUtils.mkdir_p(File.join(dir, "config"))
      yield dir
    end
  end

  def gemfile(dir)
    File.join(dir, "Gemfile")
  end

  def envfile(dir)
    File.join(dir, "config", "environment.rb")
  end
end
