# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "geo_certs/version"

Gem::Specification.new do |s|
  s.name        = "geocerts"
  s.version     = GeoCerts::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["GeoCerts, Inc."]
  s.email       = ["sslsupport@geocerts.com"]
  s.homepage    = "http://www.geocerts.com/"
  s.summary     = %q{A Ruby library for interfacing with the GeoCerts REST API}
  s.description = %q{A Ruby library for interfacing with the GeoCerts REST API}

  s.rubyforge_project = "geocerts"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'shoulda', '>=2.10.2'
  s.add_development_dependency 'factory_girl', '>=1.2.2'
  s.add_development_dependency 'mocha', '>=0.9.5'
  s.add_development_dependency 'fakeweb', '>=1.2.2'

  s.add_dependency 'relax', '>=0.1.2'
end
