module GeoCerts
  class Order
    
    class Contact
      
      attr_accessor :email,
                    :first_name,
                    :last_name,
                    :phone,
                    :title
                    
      
      def initialize(attributes = {})
        attributes.each_pair do |name, value|
          send("#{name}=", value) if respond_to?(name)
        end
      end
      
      def to_geocerts_hash
        raise(NotImplementedError)
      end
      
    end
    
  end
end