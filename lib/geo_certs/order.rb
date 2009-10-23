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

    alias         :approver= :approver_email=

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
    # This method will return an Order regardless of whether or not it was saved.
    # You should check new_record? to determine whether or not there was a failure.
    # Also, errors should not be empty if there was a failure.
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
    # This method will raise a GeoCerts::ResourceNotCreated exception if the order
    # cannot be created.
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
    # An Order will be returned whether or not validation was successful.  To
    # determine if validation was unsuccessful, you should check for errors
    # (i.e. order.errors.empty? should be true).
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
    # This method will raise GeoCerts::ResourceInvalid if the order is invalid.
    #
    def self.validate!(attributes = {}, &block)
      instance = validate(attributes, &block)
      raise(ResourceInvalid, instance.errors.collect { |e| e.message }.join(', ')) unless instance.errors.empty?
      instance
    end


    ##
    # Modifies the order state by setting it to the +action+ requested.
    #
    # Acceptable actions are: 'APPROVE' and 'CANCEL'
    #
    def modify!(action)
      update_attributes(self.class.call_api {
        GeoCerts.api.modify_order(:id => self.id, :state => action)
      })
    end

    ##
    # Instructs GeoCerts to resend the SSL certificate approval email to the
    # approval address on the order.
    #
    def resend_approval_email!
      update_attributes(self.class.call_api {
        GeoCerts.api.resend_approval_email(:id => self.id)
      })
    end

    ##
    # Updates the approver email for the SSL certificate in the order.
    #
    def change_approver_email!(email)
      update_attributes(self.class.call_api {
        GeoCerts.api.change_order_approval_email(:id => self.id, :approver_email => email)
      })
    end

    ##
    # Validates the order attributes provided.  You must, at least, provide a
    # CSR and Product:
    #
    #   GeoCerts::Order.new({
    #     :csr => "-----BEGIN CERTIFICATE REQUEST-----\n....",
    #     :product => 'QP'
    #   }).validate
    #
    # This method will return +false+ if the order is invalid.  Details of the
    # validation errors can be found in +errors+.
    #
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

    ##
    # Acts similarly to +validate+, but will raise a GeoCerts::ResourceInvalid
    # exception if validation fails.
    #
    def validate!
      validate
      raise(GeoCerts::ResourceInvalid) unless self.errors.empty?
      self
    end

    ##
    # Creates the order in the GeoCerts system.  This will also deduct the cost of
    # the order from your available balance.
    #
    # If the order cannot be created, this method will return +false+.
    #
    def save
      new_record? ? create : raise("Cannot update an existing Order")
      self.errors.empty? ? self : false
    end

    ##
    # Acts similarly to +save+, but raises a GeoCerts::ResourceNotCreated exception
    # if the order cannot be saved.
    #
    def save!
      save ? self : raise(GeoCerts::ResourceNotCreated)
    end

    ##
    # Returns +true+ if the Order has not been saved.
    #
    def new_record?
      self.id.nil?
    end

    ##
    # Sets the CSR for the order.  You can either pass a GeoCerts::CSR object, or
    # the body of a CSR.
    #
    #   order.csr = GeoCerts::CSR.new(:body => "-----BEGIN CERTIFICATE REQUEST-----\n....")
    #   order.csr = "-----BEGIN CERTIFICATE REQUEST-----\n...."
    #
    def csr=(input)
      @csr = case input
        when CSR
          input
        when Hash
          CSR.new(input)
        when String
          if input =~ /CERTIFICATE REQUEST-----/
            CSR.new({:body => input})
          else
            raise ArgumentError.new("Unrecognized CSR given.  Expected a CSR, Hash, or CSR body string, got: \"#{input.inspect}\"")
          end
        else
          raise ArgumentError.new("Unrecognized CSR given.  Expected a CSR, Hash, or CSR body string, got: \"#{input.inspect}\"")
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

    ##
    # Sets the product for the order.  You can either pass a GeoCerts::Product
    # object or the SKU for a GeoCerts product.
    #
    #   order.product = GeoCerts::Product.new(:sku => 'QP')
    #   order.product = 'QP'
    #
    def product=(input)
      @product = case input
        when Product
          input
        when String
          Product.find(input)
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
