module GeoCerts
  
  class MessageWithCode # :nodoc:
    attr_accessor :code, :message
    
    def initialize(attributes = {})
      self.code     = attributes[:code].to_i
      self.message  = attributes[:message]
    end
    
    def to_s #:nodoc:
      "#{self.class.name} ##{code}: #{message}"
    end
  end
  
  ##
  # Errors are returned when a request to GeoCerts fails.  The exception will be returned 
  # with a collection of Error objects which detail the error +code+ and +message+.
  # 
  class Error < MessageWithCode
  end
  
  ##
  # Warnings may be returned with either successful or unsuccessful requests to GeoCerts.  
  # Warnings contain the warning +code+ and +message+.
  # 
  class Warning < MessageWithCode
  end
  
end
