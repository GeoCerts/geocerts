require 'geo_certs/api_object'

module GeoCerts
  
  class Reseller < ApiObject
    
    ##
    # Returns a Float of the reseller's available balance.  This balance is 
    # for the user whose credentials are currently in use.
    # 
    #     >> GeoCerts::Reseller.balance
    #     => 5495.23
    # 
    def self.balance
      call_api { GeoCerts.api.balance }[:balance].to_f
    end
    
  end
  
end
