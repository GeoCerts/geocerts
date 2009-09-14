require 'cgi'
require 'geo_certs/api_object'
require 'geo_certs/order/administrator'
require 'geo_certs/order/extended_validation_approver'
require 'geo_certs/order/organization'
require 'geo_certs/order/renewal_information'

module GeoCerts
  
  ##
  # Contains the details, attributes, and methods to interact with a GeoCerts order.
  # 
  class Order < ApiObject
    
    attr_accessor :approver_email,
                  :completed_at,
                  :created_at,
                  :domain, 
                  :geotrust_order_id,
                  :id,
                  :licenses,
                  :sans,
                  :state,
                  :status_major,
                  :status_minor,
                  :total_price,
                  :years
    attr_reader   :administrator,
                  :csr,
                  :ev_approver,
                  :organization,
                  :pending_audit,
                  :product,
                  :renewal,
                  :renewal_information,
                  :trial,
                  :warnings
    
    force_boolean :pending_audit,
                  :renewal,
                  :trial
    
    ##
    # Returns all orders within the requested date range.  By default the server will 
    # return orders within the past month (30 days).
    # 
    # === Options
    # 
    # :start_at:: The starting DateTime for the date range
    # :end_at:: The ending DateTime for the date range
    # 
    def self.all(options = {})
      prep_date_ranges!(options)
      response = call_api { GeoCerts.api.orders(options) }
      build_collection(response) { |response| response[:orders][:order] }
    end
    
    def self.find(id)
      new(call_api { GeoCerts.api.find_order(:id => id)[:order] })
    end
    
    def self.approvers(domain)
      response = call_api { GeoCerts.api.domain_approvers(:domain => domain) }
      collection = Collection.new
      response[:emails][:email].each { |email| collection << Email.new(email) }
      collection
    end
    
    def self.create(attributes = {})
      object = new(attributes)
      yield(object) if block_given?
      object.save
      object
    end
    
    def self.validate(attributes = {})
      object = new(attributes)
      yield(object) if block_given?
      object.validate
    end
    
    
    def modify!(action)
      update_attributes(self.class.call_api {
        GeoCerts.api.modify_order(:id => self.id, :state => action)
      })
    end
    
    def resend_approval_email!
      update_attributes(self.class.call_api {
        GeoCerts.api.resend_approval_email(:id => self.id)
      })
    end
    
    def change_approver_email!(email)
      update_attributes(self.class.call_api {
        GeoCerts.api.change_order_approval_email(:id => self.id, :approver_email => email)
      })
    end
    
    def validate
      parameters = {}
      parameters[:years]        = self.years
      parameters[:licenses]     = self.licenses
      parameters[:sans]         = CGI.escape(self.sans) if self.sans
      parameters.merge!(self.csr.to_geocerts_hash)      if self.csr
      parameters.merge!(self.product.to_geocerts_hash)  if self.product
      
      Order.new(self.class.call_api {GeoCerts.api.validate_order(parameters)[:order]})
    end
    
    def save
      new_record? ? create : raise("Cannot update an existing Order")
    end
    
    def new_record?
      self.id.nil?
    end
    
    def csr=(input)
      case input
      when CSR
        @csr = input
      when Hash
        @csr = CSR.new(input)
      end
    end
    
    def renewal_information=(input)
      case input
      when RenewalInformation
        @renewal_information = input
      when Hash
        @renewal_information = RenewalInformation.new(input)
      end
    end
    
    def product=(input)
      @product = input if input.kind_of?(Product)
    end
    
    def approver=(input)
      case input
      when Approver
        @approver = input
      when Hash
        @approver = Approver.new(input)
      end
    end
    
    def ev_approver=(input)
      case input
      when ExtendedValidationApprover
        @ev_approver = input
      when Hash
        @ev_approver = ExtendedValidationApprover.new(input)
      end
    end
    
    def administrator=(input)
      case input
      when Administrator
        @administrator = input
      when Hash
        @administrator = Administrator.new(input)
      end
    end
    
    def organization=(input)
      case input
      when Organization
        @organization = input
      when Hash
        @organization = Organization.new(input)
      end
    end
    
    def warnings=(input) # :nodoc:
      case input
      when Hash
        case input[:warning]
        when Array
          @warnings = input[:warning].collect { |warning| GeoCerts::Warning.new(warning) }
        end
      end
    end
    
    ##
    # Returns a collection of events for the order.
    # 
    def events
      GeoCerts::Event.for_order(self.id)
    end
    
    ##
    # Returns a GeoCerts::Certificate associated with this order.
    # 
    def certificate
      GeoCerts::Certificate.find(self.id)
    end
    
    
    private
    
    
    def create
      parameters = {}
      parameters[:approver_email]   = self.approver_email
      parameters[:years]            = self.years
      parameters[:licenses]         = self.licenses
      parameters[:sans]             = CGI.escape(self.sans)   if self.sans
      parameters.merge!(self.csr.to_geocerts_hash)            if self.csr
      parameters.merge!(self.product.to_geocerts_hash)        if self.product
      parameters.merge!(self.ev_approver.to_geocerts_hash)    if self.ev_approver
      parameters.merge!(self.administrator.to_geocerts_hash)  if self.administrator
      parameters.merge!(self.organization.to_geocerts_hash)   if self.organization
      
      update_attributes(self.class.call_api {GeoCerts.api.create_order(parameters)[:order]})
      self
    end
    
  end
  
end
