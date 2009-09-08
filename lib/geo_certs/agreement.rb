module GeoCerts
  
  ##
  # Very simple class which contains the text of a User Agreement for a particular 
  # GeoCerts::Product.  The primary interface to this class is via 
  # GeoCerts::Product.user_agreement.
  # 
  class Agreement < ApiObject
    
    attr_accessor :text
    
    def initialize(attributes = {})
      self.text = attributes[:agreement]
    end
    
  end
  
end
