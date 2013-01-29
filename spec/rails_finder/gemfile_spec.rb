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
    def with_dir
      Dir.mktmpdir("rails_version-spec") do |dir|
        yield dir
      end
    end

    def gemfile(dir)
      File.join(dir, "Gemfile")
    end

    it "knows if file exists" do
      with_dir do |dir|
        FileUtils.touch(gemfile(dir))

        Gemfile.new(gemfile(dir)).should exist
      end
    end

    it "knows if file does not exist" do
      with_dir do |dir|
        Gemfile.new(gemfile(dir)).should_not exist
      end
    end

    it "reports Rails version" do
      with_dir do |dir|
        File.open(gemfile(dir), "w") do |file|
          file.puts(VALID_GEMFILE)
        end

        Gemfile.new(gemfile(dir)).rails_version.should == "3.2.11"
      end
    end

    it "reports none when no Rails version" do
      with_dir do |dir|
        File.open(gemfile(dir), "w") do |file|
          file.puts "source :rubygems"
          file.puts "gem 'rspec', '2.12.0'"
        end

        Gemfile.new(gemfile(dir)).rails_version.should == "n/a"
      end
    end

    it "memoizes rails version" do
      with_dir do |dir|
        File.open(gemfile(dir), "w") do |file|
          file.puts(VALID_GEMFILE)
        end

        @subject = Gemfile.new(gemfile(dir))
        @subject.rails_version.should == "3.2.11"
      end

      @subject.rails_version.should == "3.2.11"
    end
  end
end
