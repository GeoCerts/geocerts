module GeoCerts
  module Endpoints # :nodoc:
    
    module Products # :nodoc:
      
      def self.included(base)
        base.class_eval do
          endpoint GeoCerts::API::ENDPOINT do
            
            action :products, :url => '/products.xml' do
              parser Parsers::OrderParser do
                element :products do
                  elements :product do
                    element :name
                    element :sku
                    element :code
                    element 'max-years', :as => :max_years, :type => Integer
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
