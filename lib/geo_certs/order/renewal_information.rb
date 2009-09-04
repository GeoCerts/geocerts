module GeoCerts
  class Order
    
    ##
    # Organizes any renewal information received back about an Order.
    # 
    class RenewalInformation
    
      attr_accessor :months,
                    :serial_number,
                    :order_id,
                    :expires_at
      attr_reader   :indicator
    
    
      def initialize(attributes = {})
        attributes.each_pair do |name, value|
          send("#{name}=", value) if respond_to?(name)
        end
      end
    
      def indicator=(input) # :nodoc:
        @indicator = !!(input =~ /true/i)
      end
    
      alias :indicator? :indicator
    
    end
  
  end
end
