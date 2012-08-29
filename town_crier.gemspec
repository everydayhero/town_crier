# -*- encoding: utf-8 -*-
require File.expand_path('../lib/town_crier/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tim Cooper"]
  gem.email         = ["coop@latrobest.com"]
  gem.description   = "Event publishing"
  gem.summary       = "Event publishing"
  gem.homepage      = "https://github.com/everydayhero/town_crier"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "town_crier"
  gem.require_paths = ["lib"]
  gem.version       = TownCrier::VERSION

  gem.add_runtime_dependency 'bunny', '~> 0.8.0'
end
