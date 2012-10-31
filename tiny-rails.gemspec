# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tiny-rails/version'

Gem::Specification.new do |gem|
  gem.name          = "tiny-rails"
  gem.version       = TinyRails::VERSION
  gem.authors       = ["Fabio Rehm"]
  gem.email         = ["fgrehm@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  # According to https://github.com/rails/rails/blob/7dc83f78232a6dfcdd70292e831403933f57347b/railties/railties.gemspec#L26
  # The current API of the Thor gem (0.14) will remain stable at least until Thor 2.0
  gem.add_dependency 'thor', '>= 0.14.6', '< 2.0'

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'rake', '~> 0.9'
  gem.add_development_dependency 'rspec', '~> 2.0'
  gem.add_development_dependency 'guard', '~> 1.0'
end
