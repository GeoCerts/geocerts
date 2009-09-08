module GeoCerts
  
  class ApiObject # :nodoc:
    
    def initialize(attributes = {})
      update_attributes(attributes)
      yield(self) if block_given?
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
    
    
    def update_attributes(attributes) # :nodoc:
      attributes.each_pair do |name, value|
        send("#{name}=", value) if respond_to?(name)
      end
      self
    end
    
  end
  
end
