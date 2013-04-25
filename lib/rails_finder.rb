require "rails_finder/version"
require "rails_finder/app"
require "naturally"

module RailsFinder
  def self.run(dir, output = $stdout)
    Runner.new(dir, output).print
  end

  class Runner
    attr_reader :dir, :output

    def initialize(dir, output = $stdout)
      @dir = dir
      @output = output
    end

    def print
      if apps.any?
        apps.sort_by { |a| Naturally.normalize(a.rails_version) }.each do |app|
          output.puts "#{app.basename.ljust(root_width)} #{app.rails_version.ljust(version_width)} #{app.root}"
        end
      else
        output.puts "none found"
      end
    end

    def apps
      @apps ||= files_for_dir.map do |file|
        App.new(File.expand_path("../..", file))
      end
    end

    private

    def files_for_dir
      Dir["#{dir}/**/config/environment.rb"].reject { |file| file =~ /\/tmp\// }
    end

    def root_width
      @root_label_width = (apps.map { |a| a.basename.length }.max || 0) + 2
    end

    def version_width
      @version_width ||= (apps.map { |a| a.rails_version.length }.max || 0)+ 2
    end
  end
end
