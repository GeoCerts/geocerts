require 'geo_certs/order/contact'

module GeoCerts
  class Order < ApiObject
    
    ##
    # Used for setting or retrieving the Administrator associated with a GeoCerts::Order.
    # 
    class Administrator < Contact
      
      def to_geocerts_hash
        {
          :administrator_first_name => self.first_name,
          :administrator_last_name  => self.last_name,
          :administrator_phone      => self.phone,
          :administrator_email      => self.email
        }
      end
      
    end
    
  end
end
