# -*- encoding: utf-8 -*-
require File.expand_path("../lib/geo_certs/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "geocerts"
  s.version     = GeoCerts::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["GeoCerts, Inc."]
  s.email       = ["sslsupport@geocerts.com"]
  s.homepage    = "http://www.geocerts.com/"
  s.summary     = %q{A Ruby library for interfacing with the GeoCerts REST API}
  s.description = %q{A Ruby library for interfacing with the GeoCerts REST API}

  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.name          = "geocerts"
  s.require_paths = ["lib"]

  s.add_development_dependency 'shoulda', '~>2.11.0'
  s.add_development_dependency 'factory_girl', '~>1.3.0'
  s.add_development_dependency 'mocha', '~>0.9.0'
  s.add_development_dependency 'vcr', '~>1.5.0'
  s.add_development_dependency 'fakeweb', '~>1.3.0'

  s.add_dependency 'relax', '~>0.1.0'
  s.add_dependency 'libxml-ruby', '~>2.0'
end
