require 'geo_certs/order/contact'

module GeoCerts
  class Order < ApiObject
    
    ##
    # Used for setting or retrieving the Administrator associated with a GeoCerts::Order.
    # 
    class Administrator < Contact
      
      def to_geocerts_hash
        {
          :administrator_first_name => GeoCerts.escape(self.first_name),
          :administrator_last_name  => GeoCerts.escape(self.last_name),
          :administrator_phone      => GeoCerts.escape(self.phone),
          :administrator_email      => GeoCerts.escape(self.email)
        }
      end
      
    end
    
  end
end
