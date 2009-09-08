module GeoCerts
  
  class Event < ApiObject
    
    attr_accessor :id,
                  :order_id,
                  :name,
                  :created_at
    
    
    ##
    # Returns all events which occurred within the requested time window.
    # 
    def self.all
      response = call_api { GeoCerts.api.events }
      build_collection(response) { |response| response[:events][:event] }
    end
    
    ##
    # Returns all events which occurred within the requested time window for the requested
    # GeoCerts::Order.
    # 
    def self.for_order(order_id)
      order_id = order_id.id if order_id.kind_of?(GeoCerts::Order)
      build_collection(call_api { GeoCerts.api.order_events(:order_id => order_id) }) { |response|
        response[:events][:event]
      }
    end
    
  end
  
end
