require 'geo_certs/api_object'

module GeoCerts
  
  class Reseller < ApiObject
    
    def self.balance
      call_api { GeoCerts.api.balance }[:balance].to_f
    end
    
  end
  
end
