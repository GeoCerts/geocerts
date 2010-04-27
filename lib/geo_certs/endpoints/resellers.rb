module GeoCerts
  module Endpoints # :nodoc:
    
    module Resellers # :nodoc:
      
      def self.included(base)
        base.class_eval do
          endpoint GeoCerts::API::ENDPOINT do
            
            action :balance, :url => '/reseller/balance', :method => :get do
              parser Parsers::OrderParser do
                element :balance
              end
            end
            
          end
        end
      end
      
    end
    
  end
end
