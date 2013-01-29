require "rails_finder/gemfile"
require "tmpdir"
require "fileutils"

VALID_GEMFILE = <<END
source :rubygems

gem "rails", "3.2.11"
gem "jquery-rails"
END

module RailsFinder
  describe Gemfile do
    it "knows if file exists" do
      Dir.mktmpdir do |dir|
        FileUtils.touch(File.join(dir, "Gemfile"))

        Gemfile.new(File.join(dir, "Gemfile")).should exist
      end
    end

    it "knows if file does not exist" do
      Dir.mktmpdir do |dir|
        Gemfile.new(File.join(dir, "Gemfile")).should_not exist
      end
    end

    it "reports Rails version" do
      Dir.mktmpdir do |dir|
        File.open(File.join(dir, "Gemfile"), "w") do |file|
          file.puts(VALID_GEMFILE)
        end

        Gemfile.new(File.join(dir, "Gemfile")).rails_version.should == "3.2.11"
      end
    end

    it "reports none when no Rails version" do
      Dir.mktmpdir do |dir|
        File.open(File.join(dir, "Gemfile"), "w") do |file|
          file.puts "source :rubygems"
          file.puts "gem 'rspec', '2.12.0'"
        end

        Gemfile.new(File.join(dir, "Gemfile")).rails_version.should == "n/a"
      end
    end

    it "memoizes rails version" do
      Dir.mktmpdir do |dir|
        File.open(File.join(dir, "Gemfile"), "w") do |file|
          file.puts(VALID_GEMFILE)
        end

        @subject = Gemfile.new(File.join(dir, "Gemfile"))
        @subject.rails_version.should == "3.2.11"
      end

      @subject.rails_version.should == "3.2.11"
    end
  end
end
