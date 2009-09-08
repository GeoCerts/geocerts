module GeoCerts
  module Endpoints # :nodoc:
    
    module Events # :nodoc:
      
      def self.included(base)
        base.class_eval do
          endpoint GeoCerts::API::ENDPOINT do
            
            action :events, :url => '/events.xml' do
              parameter :start_at
              parameter :end_at
              
              parser Parsers::OrderParser do
                element :events do
                  attribute 'start_at',             :as => :start_at,           :type => DateTime
                  attribute 'end_at',               :as => :end_at,             :type => DateTime
                  
                  elements :event do
                    element 'event-id',             :as => :id,                 :type => Integer
                    element 'order-id',             :as => :order_id,           :type => Integer
                    element :name
                    element 'created-at',           :as => :created_at,         :type => DateTime
                  end
                end
              end
            end
            
            action :order_events, :url => '/orders/:order_id/events.xml' do
              parameter :start_at
              parameter :end_at
              
              parser Parsers::OrderParser do
                element :events do
                  attribute 'start_at',             :as => :start_at,           :type => DateTime
                  attribute 'end_at',               :as => :end_at,             :type => DateTime
                  
                  elements :event do
                    element 'event-id',             :as => :id,                 :type => Integer
                    element 'order-id',             :as => :order_id,           :type => Integer
                    element :name
                    element 'created-at',           :as => :created_at,         :type => DateTime
                  end
                end
              end
            end
            
            
          end
        end
      end
      
    end
    
  end
end
