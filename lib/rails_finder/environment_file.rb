module RailsFinder
  class EnvironmentFile
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def exists?
      File.exists?(path)
    end

    def rails_version
      return @rails_version if @rails_version

      version_line = File.readlines(path).find { |l| l =~ /RAILS_GEM_VERSION/ }
      if version_line
        @rails_version = version_line[/\d+\.\d+(\.\d+)?/].strip
      else
        @rails_version = "n/a"
      end
    end
  end
end
