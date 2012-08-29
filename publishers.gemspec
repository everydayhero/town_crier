# -*- encoding: utf-8 -*-
require File.expand_path('../lib/publishers/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tim Cooper"]
  gem.email         = ["coop@latrobest.com"]
  gem.description   = "Event publishing"
  gem.summary       = "Event publishing"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "publishers"
  gem.require_paths = ["lib"]
  gem.version       = Publishers::VERSION

  gem.add_runtime_dependency 'bunny', '~> 0.8.0'
end
