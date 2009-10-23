require 'geo_certs/parsers/order_parser'

module GeoCerts
  module Endpoints # :nodoc:

    module Orders # :nodoc:

      ELEMENTS = <<-ORDER
      element :id,                                              :type => Integer
      element 'geotrust-order-id',  :as => :geotrust_order_id
      element :domain
      element "status-major",       :as => :status_major
      element "status-minor",       :as => :status_minor
      element :years,                                           :type => Integer
      element :licenses,                                        :type => Integer
      element 'created-at',         :as => :created_at,         :type => DateTime
      element 'completed-at',       :as => :completed_at,       :type => DateTime
      element :trial
      element :renewal
      element :sans
      element :state
      element 'total-price',        :as => :total_price,        :type => Float
      element 'pending-audit',      :as => :pending_audit

      element :product do
        element :sku
      end

      element :warnings do
        elements :warning do
          element :code, :type => Float
          element :message
        end
      end
ORDER

      def self.included(base)
        base.class_eval do
          endpoint GeoCerts::API::ENDPOINT do

            action :orders, :url => '/orders.xml' do
              parameter :start_at
              parameter :end_at

              parser Parsers::OrderParser do
                attribute 'start_at',             :as => :start_at,           :type => DateTime
                attribute 'end_at',               :as => :end_at,             :type => DateTime

                element :orders do
                  elements :order do
                    eval(ELEMENTS)
                  end
                end
              end
            end

            action :find_order, :url => '/orders/:id.xml' do
              parser Parsers::OrderParser do
                element :order do
                  eval(ELEMENTS)
                end
              end
            end

            action :modify_order, :url => '/orders/:id.xml;modify', :method => :put do
              parameter 'order[state]', :as => :state, :required => true
              parser Parsers::OrderParser do
                element :order do
                  eval(ELEMENTS)
                end
              end
            end

            action :domain_approvers, :url => '/orders.xml;approvers' do
              parameter :domain, :required => true
              parser :emails do
                element :emails do
                  elements :email
                end
              end
            end

            action :resend_approval_email, :url => '/orders/:id.xml;resend', :method => :post do
              parser Parsers::OrderParser do
                element :order do
                  eval(ELEMENTS)
                end
              end
            end

            action :change_order_approval_email, :url => '/orders/:id.xml;email', :method => :put do
              parameter 'order[approver_email]', :as => :approver_email, :required => true
              parser Parsers::OrderParser do
                element :order do
                  eval(ELEMENTS)
                end
              end
            end

            action :create_order, :url => '/orders.xml', :method => :post do
              parameter 'order[years]',                   :as => :years
              parameter 'order[licenses]',                :as => :licenses
              parameter 'order[dns_names]',               :as => :sans
              parameter 'order[approver_email]',          :as => :approver_email

              parameter 'order[product][sku]',            :as => :product_sku
              parameter 'order[csr][body]',               :as => :csr_body

              parameter 'order[ev_approver][first_name]', :as => :ev_approver_first_name
              parameter 'order[ev_approver][last_name]',  :as => :ev_approver_last_name
              parameter 'order[ev_approver][title]',      :as => :ev_approver_title
              parameter 'order[ev_approver][phone]',      :as => :ev_approver_phone
              parameter 'order[ev_approver][email]',      :as => :ev_approver_email

              parameter 'order[organization][organization_name]', :as => :organization_name
              parameter 'order[organization][address]',           :as => :organization_address
              parameter 'order[organization][city]',              :as => :organization_city
              parameter 'order[organization][state]',             :as => :organization_state
              parameter 'order[organization][postal_code]',       :as => :organization_postal_code
              parameter 'order[organization][phone]',             :as => :organization_phone

              parser Parsers::OrderParser do
                element :order do
                  eval(ELEMENTS)
                end
              end
            end

            action :validate_order, :url => '/orders.xml;validate', :method => :post do
              parameter 'order[product][sku]',  :as => :product_sku
              parameter 'order[csr][body]',     :as => :csr_body
              parameter 'order[years]',         :as => :years
              parameter 'order[licenses]',      :as => :licenses
              parameter 'order[dns_names]',     :as => :sans

              parser Parsers::OrderParser do
                element :order do
                  element 'total-price',        :as => :total_price,        :type => Float

                  element :csr do
                    element 'common-name',      :as => :common_name
                    element :city
                    element :state
                    element :country
                    element :organization
                    element 'org-unit',         :as => :organizational_unit
                    element :body
                  end

                  element 'renewal-info',       :as => :renewal_information do
                    element :indicator
                    element :months,                                        :type => Integer
                    element 'serial-number',    :as => :serial_number
                    element 'order-id',         :as => :order_id
                    element 'expiration-date',  :as => :expires_at,         :type => DateTime
                  end

                  element :warnings do
                    elements :warning do
                      element :code, :type => Float
                      element :message
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
end
