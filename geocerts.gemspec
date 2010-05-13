# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{geocerts}
  s.version = "0.0.24"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["GeoCerts, Inc."]
  s.date = %q{2010-05-13}
  s.description = %q{A Ruby library for interfacing with the GeoCerts REST API}
  s.email = %q{sslsupport@geocerts.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "autotest/discover.rb",
     "geocerts.gemspec",
     "lib/geo_certs.rb",
     "lib/geo_certs/agreement.rb",
     "lib/geo_certs/api.rb",
     "lib/geo_certs/api_object.rb",
     "lib/geo_certs/certificate.rb",
     "lib/geo_certs/collection.rb",
     "lib/geo_certs/csr.rb",
     "lib/geo_certs/email.rb",
     "lib/geo_certs/endpoints/agreements.rb",
     "lib/geo_certs/endpoints/certificates.rb",
     "lib/geo_certs/endpoints/events.rb",
     "lib/geo_certs/endpoints/hello.rb",
     "lib/geo_certs/endpoints/orders.rb",
     "lib/geo_certs/endpoints/products.rb",
     "lib/geo_certs/endpoints/resellers.rb",
     "lib/geo_certs/errors.rb",
     "lib/geo_certs/event.rb",
     "lib/geo_certs/exceptions.rb",
     "lib/geo_certs/hash_extension.rb",
     "lib/geo_certs/hello.rb",
     "lib/geo_certs/order.rb",
     "lib/geo_certs/order/administrator.rb",
     "lib/geo_certs/order/contact.rb",
     "lib/geo_certs/order/extended_validation_approver.rb",
     "lib/geo_certs/order/organization.rb",
     "lib/geo_certs/order/renewal_information.rb",
     "lib/geo_certs/parsers/order_parser.rb",
     "lib/geo_certs/product.rb",
     "lib/geo_certs/reseller.rb",
     "lib/geocerts.rb",
     "test/config/initializers/_remote_tests.rb",
     "test/config/initializers/fakeweb.rb",
     "test/config/initializers/geocerts.rb",
     "test/config/initializers/responses.rb",
     "test/config/test_credentials.example.yml",
     "test/factories.rb",
     "test/fixtures/responses.rb",
     "test/fixtures/responses/agreement.rb",
     "test/fixtures/responses/certificate.rb",
     "test/fixtures/responses/event.rb",
     "test/fixtures/responses/hello.rb",
     "test/fixtures/responses/order.rb",
     "test/fixtures/responses/product.rb",
     "test/integrations/agreement_test.rb",
     "test/integrations/api_test.rb",
     "test/integrations/certificate_test.rb",
     "test/integrations/event_test.rb",
     "test/integrations/hello_test.rb",
     "test/integrations/order_test.rb",
     "test/integrations/product_test.rb",
     "test/test_helper.rb",
     "test/units/certificate_test.rb",
     "test/units/collection_test.rb",
     "test/units/csr_test.rb",
     "test/units/geo_certs_test.rb",
     "test/units/order/administrator_test.rb",
     "test/units/order/extended_validation_approver_test.rb",
     "test/units/order/organization_test.rb",
     "test/units/order/renewal_information_test.rb",
     "test/units/order_test.rb",
     "test/units/product_test.rb"
  ]
  s.homepage = %q{http://www.geocerts.com/}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{A Ruby library for interfacing with the GeoCerts REST API}
  s.test_files = [
    "test/config/initializers/_remote_tests.rb",
     "test/config/initializers/fakeweb.rb",
     "test/config/initializers/geocerts.rb",
     "test/config/initializers/responses.rb",
     "test/factories.rb",
     "test/fixtures/responses/agreement.rb",
     "test/fixtures/responses/certificate.rb",
     "test/fixtures/responses/event.rb",
     "test/fixtures/responses/hello.rb",
     "test/fixtures/responses/order.rb",
     "test/fixtures/responses/product.rb",
     "test/fixtures/responses.rb",
     "test/integrations/agreement_test.rb",
     "test/integrations/api_test.rb",
     "test/integrations/certificate_test.rb",
     "test/integrations/event_test.rb",
     "test/integrations/hello_test.rb",
     "test/integrations/order_test.rb",
     "test/integrations/product_test.rb",
     "test/test_helper.rb",
     "test/units/certificate_test.rb",
     "test/units/collection_test.rb",
     "test/units/csr_test.rb",
     "test/units/geo_certs_test.rb",
     "test/units/order/administrator_test.rb",
     "test/units/order/extended_validation_approver_test.rb",
     "test/units/order/organization_test.rb",
     "test/units/order/renewal_information_test.rb",
     "test/units/order_test.rb",
     "test/units/product_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<relax>, [">= 0.1.2"])
      s.add_development_dependency(%q<shoulda>, [">= 2.10.2"])
      s.add_development_dependency(%q<factory_girl>, [">= 1.2.2"])
      s.add_development_dependency(%q<mocha>, [">= 0.9.5"])
      s.add_development_dependency(%q<fakeweb>, [">= 1.2.2"])
    else
      s.add_dependency(%q<relax>, [">= 0.1.2"])
      s.add_dependency(%q<shoulda>, [">= 2.10.2"])
      s.add_dependency(%q<factory_girl>, [">= 1.2.2"])
      s.add_dependency(%q<mocha>, [">= 0.9.5"])
      s.add_dependency(%q<fakeweb>, [">= 1.2.2"])
    end
  else
    s.add_dependency(%q<relax>, [">= 0.1.2"])
    s.add_dependency(%q<shoulda>, [">= 2.10.2"])
    s.add_dependency(%q<factory_girl>, [">= 1.2.2"])
    s.add_dependency(%q<mocha>, [">= 0.9.5"])
    s.add_dependency(%q<fakeweb>, [">= 1.2.2"])
  end
end

