module GeoCerts

  class FraudScore < ApiObject

    attr_accessor :ip, :city, :region, :postal_code, :country, :domain, :bin, :bin_name, :bin_phone, :phone, :forwarded_ip, :email, :username, :password, :shipping_address, :shipping_city, :shipping_region, :shipping_postal_code, :shipping_country, :transaction_id, :session_id, :user_agent, :accept_language
    attr_accessor :country_match, :country_code, :high_risk_country, :distance, :ip_region, :ip_city, :ip_latitude, :ip_longitude, :ip_isp, :ip_org, :anonymous_proxy, :proxy_score, :transparent_proxy, :freemail, :carder_email, :high_risk_username, :high_risk_password, :bin_match, :bin_country, :bin_name_match, :bin_name, :bin_phone_match, :bin_phone, :phone_in_billing_location, :ship_forward, :city_postal_match, :ship_city_postal_match, :explanation, :risk_score, :queries_remaining, :error

    force_boolean :country_match, :high_risk_country, :anonymous_proxy, :transparent_proxy, :freemail, :carder_email, :high_risk_username, :high_risk_password, :bin_match, :bin_phone_match, :ship_forward, :city_postal_match, :ship_city_postal_match, :phone_in_billing_location

    def self.query(attributes = {}, &block)
      new(attributes, &block).query
    end

    ##
    # Queries the GeoCerts FraudScore API for details about the
    # payment being processed.
    #
    def query
      update_attributes(self.class.call_api {GeoCerts.api.query_fraud_score(api_attributes)['fraud-score']})
    end


    private


    def api_attributes
      {
        :ip => @ip,
        :city => @city,
        :region => @region,
        :postal_code => @postal_code,
        :country => @country
      }
    end

  end

end
