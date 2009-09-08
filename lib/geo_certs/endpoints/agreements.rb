module GeoCerts
  module Endpoints # :nodoc:
    
    module Agreements # :nodoc:
      
      def self.included(base)
        base.class_eval do
          endpoint GeoCerts::API::ENDPOINT do
            
            action :agreement, :url => '/products/:product_id/agreement.xml' do
              parser Parsers::OrderParser do
                element :agreement
              end
            end
            
          end
        end
      end
      
    end
    
  end
end
