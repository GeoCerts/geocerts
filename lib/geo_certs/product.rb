require 'geo_certs/api_object'

module GeoCerts
  
  ##
  # The Product simply holds details about a specific product offered by GeoCerts.
  # 
  class Product < ApiObject
    
    attr_accessor :name, :sku, :max_years
    
    
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
    # === Exceptions
    # 
    # If the +sku+ cannot be located in the GeoCerts system, a GeoCerts::ResourceNotFound 
    # exception is raised.
    # 
    def self.find(sku)
      all.detect { |product| product.sku == sku } || raise(GeoCerts::ResourceNotFound, "No product was found matching \"#{sku}\" sku")
    end
    
    ##
    # Returns a GeoCerts product by product SKU.
    # 
    # This method returns +nil+ if the SKU cannot be found on the GeoCerts system and does not
    # raise an exception for this event.
    # 
    def self.find_by_sku(sku)
      find(sku)
    rescue GeoCerts::AllowableExceptionWithResponse
      nil
    end
    
    
    def initialize(attributes = {})
      self.name       = attributes[:name]
      self.sku        = attributes[:sku]
      self.max_years  = attributes[:max_years]
    end
    
    ##
    # Returns the GeoCerts::Agreement for this product.
    # 
    def user_agreement
      GeoCerts::Agreement.new(self.class.call_api {
        GeoCerts.api.agreement(:product_id => self.sku)
      })
    end
    
    def to_geocerts_hash
      { :product_sku => GeoCerts.escape(self.sku) }
    end
    
  end
  
end
