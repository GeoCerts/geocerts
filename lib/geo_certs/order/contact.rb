module GeoCerts
  class Order < ApiObject
    
    ##
    # Used for setting or retrieving the Contact information associated with a 
    # GeoCerts::Order.
    # 
    class Contact # :nodoc:all
      
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