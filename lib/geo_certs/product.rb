module GeoCerts
  
  ##
  # The Product simply holds details about a specific product offered by GeoCerts.
  # 
  class Product
    
    attr_accessor :name, :sku, :max_years
    
    def initialize(attributes = {})
      self.name       = attributes[:name]
      self.sku        = attributes[:sku]
      self.max_years  = attributes[:max_years]
    end
    
  end
  
end
