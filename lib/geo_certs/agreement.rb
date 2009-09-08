module GeoCerts
  
  class Agreement < ApiObject
    
    attr_accessor :text
    
    def initialize(attributes = {})
      self.text = attributes[:agreement]
    end
    
  end
  
end
