require 'geo_certs/api_object'

module GeoCerts
  
  class Certificate < ApiObject
    
    attr_accessor :order_id,
                  :geotrust_order_id,
                  :status,
                  :certificate,
                  :ca_root,
                  :common_name,
                  :serial_number,
                  :start_at,
                  :end_at,
                  :city,
                  :state,
                  :country,
                  :organization,
                  :organizational_unit,
                  :approver_email,
                  :reissue_email,
                  :trial,
                  :url
    
    force_boolean :trial
    
    ##
    # Returns all certificates for a given window of time.
    # 
    def self.all
      response = call_api { GeoCerts.api.certificates }
      build_collection(response) { |response| response[:certificates][:certificate] }
    end
    
    ##
    # Returns the certificate for the given GeoCerts::Order
    def self.find(order_id)
      order_id = order_id.id if order_id.kind_of?(GeoCerts::Order)
      new(call_api { GeoCerts.api.find_certificate(:order_id => order_id)[:certificate] })
    end
    
    
    ##
    # Reissues the certificate given a proper CSR.
    # 
    def reissue!(csr)
      csr = csr.body if csr.kind_of?(GeoCerts::CSR)
      update_attributes(self.class.call_api {
        GeoCerts.api.reissue_certificate({
          :order_id => self.order_id,
          :csr_body => CGI.escape(csr || '')
        })
      })
    end
    
  end
  
end
