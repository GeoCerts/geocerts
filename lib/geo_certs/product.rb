require 'geo_certs/api_object'

module GeoCerts
  
  ##
  # The Product simply holds details about a specific product offered by GeoCerts.
  # 
  class Product < ApiObject
    
    attr_accessor :name, :sku, :max_years, :code
    
    
    ##
    # Returns all products available via the GeoCerts API.
    # 
    def self.all
      response = call_api { GeoCerts.api.products }
      build_collection(response) { |response| response[:products][:product] }
    end
    
    ##
    # Returns a GeoCerts product by product SKU.
    # 
    def self.find(sku)
      all.detect { |product| product.sku == sku }
    end
    
    
    def initialize(attributes = {})
      self.name       = attributes[:name]
      self.sku        = attributes[:sku]
      self.max_years  = attributes[:max_years]
      self.code       = attributes[:code]
    end
    
    ##
    # Returns the GeoCerts::Agreement for this product.
    # 
    def user_agreement
      GeoCerts::Agreement.new(self.class.call_api {
        GeoCerts.api.agreement(:product_id => self.code)
      })
    end
    
    def to_geocerts_hash
      { :product_sku => self.sku }
    end
    
  end
  
end
