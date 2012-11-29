# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tiny-rails/version'

Gem::Specification.new do |gem|
  gem.name          = "tiny-rails"
  gem.version       = TinyRails::VERSION
  gem.authors       = ["Fabio Rehm"]
  gem.email         = ["fgrehm@gmail.com"]
  gem.description   = %q{A generator for tiny Rails apps}
  gem.summary       = gem.description
  gem.homepage      = 'http://github.com/fgrehm/tiny-rails'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'thor', '>= 0.14.6', '< 2.0'

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'rake', '~> 0.9'
  gem.add_development_dependency 'rspec', '~> 2.0'
  gem.add_development_dependency 'rspec-spies', '~> 2.1'
  gem.add_development_dependency 'guard-rspec', '~> 2.0'
end
