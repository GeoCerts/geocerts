require 'geo_certs/exceptions'
require 'geo_certs/collection'
require 'geo_certs/email'
require 'geo_certs/csr'
require 'geo_certs/product'
require 'geo_certs/order'
require 'geo_certs/certificate'
require 'geo_certs/agreement'
require 'geo_certs/event'
require 'geo_certs/hello'
require 'geo_certs/endpoints/orders'
require 'geo_certs/endpoints/certificates'
require 'geo_certs/endpoints/agreements'
require 'geo_certs/endpoints/products'
require 'geo_certs/endpoints/events'
require 'geo_certs/endpoints/hello'

module GeoCerts
  
  class API < Relax::Service # :nodoc:
    
    ENDPOINT = "https://:host/:version"
    
    include Endpoints::Orders
    include Endpoints::Certificates
    include Endpoints::Products
    include Endpoints::Agreements
    include Endpoints::Events
    include Endpoints::Hello
  end
  
end
