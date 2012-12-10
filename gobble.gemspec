# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gobble/version'

Gem::Specification.new do |gem|
  gem.name          = "gobble"
  gem.version       = Gobble::VERSION
  gem.authors       = ["Rob Howard"]
  gem.email         = ["rob@robhoward.id.au"]
  gem.description   = "Gobble is a fake web service handler for integration testing."
  gem.summary       = "Gobble is a fake web service handler for integration testing.\n\nYou need Gobble if you have a site that makes calls to web services with a client that you can't mock or stub out, eg. something that isn't able to be tested with Rack::Test."
  gem.homepage      = "https://github.com/damncabbage/gobble"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
