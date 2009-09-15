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
                  :trial
    
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
    
    ##
    # Returns a GeoCerts order by the order +id+ given.
    # 
    # === Exceptions
    # 
    # If the +id+ cannot be found on the GeoCerts system, a GeoCerts::ResourceNotFound exception
    # will be raised.
    # 
    def self.find(id)
      new(call_api { GeoCerts.api.find_order(:id => id)[:order] })
    end
    
    ##
    # Similar to GeoCerts::Product.find, but instead of raising an exception when an order cannot
    # be located, instead it will return +nil+.
    # 
    # See GeoCerts::Product.find for more information.
    # 
    def self.find_by_id(id)
      find(id)
    rescue GeoCerts::AllowableExceptionWithResponse
      nil
    end
    
    def self.approvers(domain)
      response = call_api { GeoCerts.api.domain_approvers(:domain => domain) }
      collection = Collection.new
      response[:emails][:email].each { |email| collection << Email.new(email) }
      collection
    end
    
    ##
    # Creates a new order on GeoCerts with the attributes given.
    # 
    # If the order cannot be successfully created, this method will return +false+.
    # 
    def self.create(attributes = {}, &block)
      object = new(attributes, &block)
      object.save
      object
    end
    
    ##
    # Creates a new order on GeoCerts with the attributes given.
    # 
    # === Exceptions
    # 
    # This method will raise a GeoCerts::UnprocessableEntity exception if the order cannot be 
    # created.
    # 
    def self.create!(attributes = {}, &block)
      instance = create(attributes, &block)
      raise(ResourceNotCreated, instance.errors.collect { |e| e.message }.join(', ')) if instance.new_record?
      instance
    end
    
    ##
    # Validates an order with the attributes provided.  This method will also parse a given CSR
    # body and populate the returned Order's CSR object with the parsed data.
    # 
    # If validation fails, this method will return +false+.
    # 
    def self.validate(attributes = {}, &block)
      object = new(attributes, &block)
      object.validate
      object
    end
    
    ##
    # See GeoCerts::Order.validate for more information.
    # 
    # === Exceptions
    # 
    # This method will raise GeoCerts::UnprocessableEntity if the order is invalid.
    # 
    def self.validate!(attributes = {}, &block)
      instance = validate(attributes, &block)
      raise(ResourceInvalid, instance.errors.collect { |e| e.message }.join(', ')) unless instance.errors.empty?
      instance
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
      
      update_attributes(self.class.call_api {GeoCerts.api.validate_order(parameters)[:order]})
    rescue GeoCerts::AllowableExceptionWithResponse
      store_exception_errors_and_warnings($!)
      false
    end
    
    def validate!
      validate
      raise(GeoCerts::ResourceInvalid) unless self.errors.empty?
      self
    end
    
    def save
      new_record? ? create : raise("Cannot update an existing Order")
      self.errors.empty? ? self : false
    end
    
    def save!
      save ? self : raise(GeoCerts::ResourceNotCreated)
    end
    
    def new_record?
      self.id.nil?
    end
    
    def csr=(input)
      @csr = case input
        when CSR
          input
        when Hash
          CSR.new(input)
        when String
          CSR.new({:body => input}) if input =~ /-----BEGIN CERTIFICATE REQUEST-----/
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
      @product = case input
        when Product
          input
        when String
          Product.find(input)
        end
    end
    
    def approver=(input)
      @approver = case input
        when Approver
          input
        when Hash
          Approver.new(input)
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
    
    ##
    # Returns a collection of events for the order.
    # 
    def events
      GeoCerts::Event.find_by_order_id(self.id)
    end
    
    ##
    # Returns a GeoCerts::Certificate associated with this order.
    # 
    def certificate
      GeoCerts::Certificate.find_by_order_id(self.id)
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
    rescue GeoCerts::AllowableExceptionWithResponse
      store_exception_errors_and_warnings($!)
      self
    end
    
  end
  
end
