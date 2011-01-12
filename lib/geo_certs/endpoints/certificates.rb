module GeoCerts
  module Endpoints # :nodoc:
    
    module Certificates # :nodoc:
      
      ELEMENTS = <<-CERTIFICATE
      element 'order-id',             :as => :order_id
      element 'geotrust-order-id',    :as => :geotrust_order_id
      element :status
      element :certificate
      element 'ca-root',              :as => :ca_root
      element 'ca-intermediates',     :as => :ca_intermediates do
        elements 'ca-intermediate',   :as => :ca_intermediate
      end
      element 'common-name',          :as => :common_name
      element 'serial-number',        :as => :serial_number
      element 'start-date',           :as => :start_at,           :type => DateTime
      element 'end-date',             :as => :end_at,             :type => DateTime
      element :locality,              :as => :city
      element :state
      element :organization
      element 'organizational-unit',  :as => :organizational_unit
      element :country
      element :trial
      element :url
      element 'dns-names',            :as => :sans
CERTIFICATE
      
      def self.included(base)
        base.class_eval do
          endpoint GeoCerts::API::ENDPOINT do
            
            action :certificates, :url => '/certificates.xml' do
              parameter :start_at
              parameter :end_at
              
              parser Parsers::OrderParser do
                attribute 'start_at',             :as => :start_at,           :type => DateTime
                attribute 'end_at',               :as => :end_at,             :type => DateTime
                
                element :certificates do
                  elements :certificate, :xpath => 'certificates/certificate' do
                    eval(ELEMENTS)
                  end
                end
              end
            end
            
            action :find_certificate, :url => '/orders/:order_id/certificate.xml' do
              parser Parsers::OrderParser do
                element :certificate,     :xpath => '/certificate' do
                  eval(ELEMENTS)
                  element :certificate,   :xpath => '/certificate/certificate/text()'
                end
              end
            end
            
            action :reissue_certificate, :url => '/orders/:order_id/certificate/reissue.xml', :method => :post do
              parameter 'certificate[csr][body]',     :as => :csr_body
              parser Parsers::OrderParser do
                element :certificate,     :xpath => '/certificate' do
                  eval(ELEMENTS)
                end
              end
            end
            
          end
        end
      end
      
    end
    
  end
end
