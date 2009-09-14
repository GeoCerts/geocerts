module GeoCerts
  
  ##
  # GeoCerts tracks events which occur that are related to your Order(s).  This class 
  # interfaces with those events to provide collections of all of your events or events
  # against a particular GeoCerts::Order.
  # 
  class Event < ApiObject
    
    attr_accessor :id,
                  :order_id,
                  :name,
                  :created_at
    
    
    ##
    # Returns all events which occurred within the requested time window.  The server 
    # defaults to a 15 minute window.
    # 
    # == Options
    # 
    # :start_at:: The starting DateTime for the date range
    # :end_at:: The ending DateTime for the date range
    # 
    def self.all(options = {})
      prep_date_ranges!(options)
      response = call_api { GeoCerts.api.events(options) }
      build_collection(response) { |response| response[:events][:event] }
    end
    
    ##
    # Returns all events which occurred within the requested time window for the requested
    # GeoCerts::Order.  The server defaults to a 15 minute window.
    # 
    # == Options
    # 
    # :start_at:: The starting DateTime for the date range
    # :end_at:: The ending DateTime for the date range
    # 
    # === Exceptions
    # 
    # This method will raise GeoCerts exceptions if the requested +order_id+ cannot be found.
    # 
    def self.find(order_id, options = {})
      prep_date_ranges!(options)
      order_id = order_id.id if order_id.kind_of?(GeoCerts::Order)
      options[:order_id]  = order_id
      build_collection(call_api { GeoCerts.api.order_events(options) }) { |response|
        response[:events][:event]
      }
    end
    
    ##
    # This method will not raise an exception for a missing +order_id+ in the GeoCerts system.  
    # Instead, it will return an empty collection.
    # 
    # See GeoCerts::Event.find for more information.
    # 
    def self.find_by_order_id(order_id, options = {})
      find(order_id, options)
    rescue GeoCerts::AllowableExceptionWithResponse
      []
    end
    
  end
  
end
