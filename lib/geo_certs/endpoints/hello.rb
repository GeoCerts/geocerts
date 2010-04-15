module GeoCerts
  module Endpoints # :nodoc:
    
    module Hello # :nodoc:
      
      def self.included(base)
        base.class_eval do
          endpoint GeoCerts::API::ENDPOINT do
            
            action :hello, :url => '/hello.xml', :method => :post do
              parameter :hello, :required => true
              parser Parsers::OrderParser do
                element :hello
              end
            end
            
          end
        end
      end
      
    end
    
  end
end
