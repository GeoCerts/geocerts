require 'geo_certs/exceptions'
require 'geo_certs/collection'
require 'geo_certs/email'
require 'geo_certs/csr'
require 'geo_certs/product'
require 'geo_certs/order'
require 'geo_certs/certificate'
require 'geo_certs/endpoints/orders'
require 'geo_certs/endpoints/certificates'

module GeoCerts
  
  class API < Relax::Service # :nodoc:
    
    # ENDPOINT = 'http://localhost:3000/:version'
    ENDPOINT = "https://api-test.geocerts.com/:version"
    
    include Endpoints::Orders
    include Endpoints::Certificates
  end
  
end
