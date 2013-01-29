module RailsFinder
  class App
    attr_reader :root

    def initialize(root)
      @root = root
    end

    def basename
      File.basename(root)
    end

    def rails_version
      if gemfile.exists?
        gemfile.rails_version
      elsif envfile.exists?
        envfile.rails_version
      else
        "n/a"
      end
    end

    private

    def gemfile
      @gemfile ||= Gemfile.new(File.join(root, "Gemfile"))
    end

    def envfile
      @envfile ||= EnvironmentFile.new(File.join(root, "config", "environment.rb"))
    end
  end
end
