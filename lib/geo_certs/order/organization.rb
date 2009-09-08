module GeoCerts
  class Order < ApiObject
    
    class Organization
      
      attr_accessor   :address,
                      :address_2,
                      :address_3,
                      :city,
                      :country,
                      :name,
                      :phone,
                      :postal_code,
                      :state
      
      def initialize(attributes = {})
        attributes.each_pair do |name, value|
          send("#{name}=", value) if respond_to?(name)
        end
      end
      
      def to_geocerts_hash
        {
          :organization_address     => self.address,
          :organization_address_2   => self.address_2,
          :organization_address_3   => self.address_3,
          :organization_city        => self.city,
          :organization_country     => self.country,
          :organization_name        => self.name,
          :organization_phone       => self.phone,
          :organization_postal_code => self.postal_code,
          :organization_state       => self.state
        }
      end
      
    end
    
  end
end
