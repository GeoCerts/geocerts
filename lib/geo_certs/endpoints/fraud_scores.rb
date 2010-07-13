require 'geo_certs/parsers/order_parser'

module GeoCerts
  module Endpoints
    module FraudScores

      def self.included(base)
        base.class_eval do
          endpoint GeoCerts::API::ENDPOINT do
            action :query_fraud_score, :url => '/fraud_score.xml', :method => :post do
              parameter 'fraud_score[ip]', :required => true, :as => :ip
              parameter 'fraud_score[city]', :required => true, :as => :city
              parameter 'fraud_score[region]', :required => true, :as => :region
              parameter 'fraud_score[postal_code]', :required => true, :as => :postal_code
              parameter 'fraud_score[country]', :required => true, :as => :country

              parser Parsers::OrderParser do
                element 'fraud-score' do
                  element 'country-match', :as => :country_match
                  element 'country-code', :as => :country_code
                  element 'high-risk-country', :as => :high_risk_country
                  element 'distance', :type => Float
                  element 'ip-region', :as => :ip_region
                  element 'ip-city', :as => :ip_city
                  element 'ip-latitude', :as => :ip_latitude, :type => Float
                  element 'ip-longitude', :as => :ip_longitude, :type => Float
                  element 'ip-isp', :as => :ip_isp
                  element 'ip-org', :as => :ip_org
                  element 'anonymous-proxy', :as => :anonymous_proxy
                  element 'proxy-score', :as => :proxy_score, :type => Float
                  element 'transparent-proxy', :as => :transparent_proxy
                  element 'freemail'
                  element 'carder-email', :as => :carder_email
                  element 'high-risk-username', :as => :high_risk_username
                  element 'high-risk-password', :as => :high_risk_password
                  element 'bin-match', :as => :bin_match
                  element 'bin-country', :as => :bin_country
                  element 'bin-name-match', :as => :bin_name_match
                  element 'bin-name', :as => :bin_name
                  element 'bin-phone-match', :as => :bin_phone_match
                  element 'bin-phone', :as => :bin_phone
                  element 'phone-in-billing-location', :as => :phone_in_billing_location
                  element 'ship-forward', :as => :ship_forward
                  element 'city-postal-match', :as => :city_postal_match
                  element 'ship-city-postal-match', :as => :ship_city_postal_match
                  element 'explanation'
                  element 'queries-remaining', :as => :queries_remaining, :type => Integer
                  element 'risk-score', :as => :risk_score, :type => Float
                  element 'error'
                end
              end
            end
          end
        end
      end

    end
  end
end
