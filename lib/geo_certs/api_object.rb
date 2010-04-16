module GeoCerts
  
  class ApiObject # :nodoc:
    
    attr_accessor :response_parameters
    
    def initialize(attributes = {}, &block)
      update_attributes(attributes)
      yield(self) if block_given?
    end
    
    def errors
      @errors ||= []
    end
    
    def warnings
      @warnings ||= []
    end
    
    def warnings=(input) # :nodoc:
      @warnings = case input
        when Hash
          case input[:warning]
          when Array
            input[:warning].collect { |warning| GeoCerts::Warning.new(warning) }
          end
        when Array
          input if input.all? { |item| item.kind_of?(GeoCerts::Warning) }
        end
    end
    
    def errors=(input) # :nodoc:
      @errors = case input
        when Hash
          case input[:error]
          when Array
            input[:error].collect { |error| GeoCerts::Error.new(error) }
          end
        when Array
          input if input.all? { |item| item.kind_of?(GeoCerts::Error) }
        end
    end
    
    
    protected
    
    
    def self.call_api # :nodoc:
      yield if block_given?
    rescue RestClient::ResourceNotFound
      raise GeoCerts::ResourceNotFound.new($!)
    rescue RestClient::Unauthorized
      raise GeoCerts::Unauthorized.new($!)
    rescue RestClient::RequestFailed
      case $!.http_code
      when 422
        raise GeoCerts::UnprocessableEntity.new($!)
      when 400
        raise GeoCerts::BadRequest.new($!)
      else
        raise GeoCerts::RequestFailed.new($!)
      end
    rescue RestClient::RequestTimeout
      raise GeoCerts::RequestTimeout.new($!.message)
    rescue *GeoCerts::HTTP_ERRORS
      raise GeoCerts::ConnectionError.new($!.message)
    # rescue
    #   raise GeoCerts::Exception.from($!)
    end
    
    def self.force_boolean(*attributes) # :nodoc:
      attributes.each do |attribute|
        define_method("#{attribute}=") do |input|       # def trial=(input)
          instance_variable_set("@#{attribute}",        #   @trial =
                                !!(input =~ /true/i))   #     !!(input =~ /true/i)
        end                                             # end
        
        define_method("#{attribute}?") do               # def trial?
          send(attribute.to_sym)                        #   send(:trial)
        end                                             # end
      end
    end
    
    def self.build_collection(response) # :nodoc:
      raise(ArgumentError, "Missing block") unless block_given?
      collection = Collection.new
      collection.start_at = response[:start_at]
      collection.end_at   = response[:end_at]
      yield(response).each { |order| collection << new(order) }
      collection
    end
    
    def self.prep_date_ranges!(options)
      options[:start_at]  = options[:start_at].xmlschema  if options.has_key?(:start_at)  && options[:start_at].respond_to?(:xmlschema)
      options[:end_at]    = options[:end_at].xmlschema    if options.has_key?(:end_at)    && options[:start_at].respond_to?(:xmlschema)
    end
    
    
    def store_exception_errors_and_warnings(exception)
      self.warnings = exception.warnings  if exception.respond_to?(:warnings)
      self.errors   = exception.errors    if exception.respond_to?(:errors)
      self.response_parameters = exception.parameters if exception.respond_to?(:parameters)
    end
    
    def update_attributes(attributes) # :nodoc:
      attributes.each_pair do |name, value|
        send("#{name}=", value) if respond_to?(name)
      end
      self
    end
    
  end
  
end
