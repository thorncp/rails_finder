module RailsFinder
  class IsolateFile
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def exists?
      File.exists?(path)
    end

    def rails_version
      return @rails_version if @rails_version
      line = File.readlines(path).find { |l| l =~ /^gem.+rails/i }
      if line
        @rails_version = line[/\d+\.\d+(\.\d+)?/]
      else
        @rails_version = "n/a"
      end
    end
  end
end

