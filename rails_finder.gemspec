# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_finder/version'

Gem::Specification.new do |gem|
  gem.name          = "rails_finder"
  gem.version       = RailsFinder::VERSION
  gem.authors       = ["Chris Thorn", "Tobi Lehman"]
  gem.email         = ["thorncp@gmail.com", "tobi.lehman@gmail.com"]
  gem.description   = %q{Overly simple utility to recursively find Rails apps and their versions}
  gem.summary       = %q{Overly simple utility to recursively find Rails apps and their versions}
  gem.homepage      = "https://github.com/thorncp/rails_finder"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "naturally", "~> 1.0.3"

  gem.add_development_dependency "rspec", "~> 2.12.0"
  gem.add_development_dependency "rake", "~> 10.0.3"
end
