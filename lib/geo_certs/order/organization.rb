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
      
      def to_geocerts_hash #:nodoc:
        {
          :organization_address     => GeoCerts.escape(self.address),
          :organization_address_2   => GeoCerts.escape(self.address_2),
          :organization_address_3   => GeoCerts.escape(self.address_3),
          :organization_city        => GeoCerts.escape(self.city),
          :organization_country     => GeoCerts.escape(self.country),
          :organization_name        => GeoCerts.escape(self.name),
          :organization_phone       => GeoCerts.escape(self.phone),
          :organization_postal_code => GeoCerts.escape(self.postal_code),
          :organization_state       => GeoCerts.escape(self.state)
        }
      end
      
    end
    
  end
end
