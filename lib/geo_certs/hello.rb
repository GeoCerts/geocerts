module GeoCerts
  
  ##
  # The lowest level class/method to test your credentials and connectivity
  # with the GeoCerts API.  If everything is properly configured, then a call 
  # to GeoCerts::Hello.message('my message') will result in a response 
  # matching your message:
  # 
  #     hello = GeoCerts::Hello.message('testing')  # => <GeoCerts::Hello @hello="testing">
  #     hello.result                                # => 'testing'
  #     hello.hello                                 # => 'testing'
  #     'testing' == hello.result                   # => true
  # 
  class Hello < ApiObject
    
    attr_accessor :hello
    alias :result :hello
    
    
    ##
    # Pass any message in to Hello and if everything is properly configured,
    # you will receive back a matching message in the response result.
    # 
    def self.message(message)
      new(call_api { GeoCerts.api.hello(:hello => GeoCerts.escape(message)) })
    end
    
    
    def initialize(attributes = {})
      self.hello = attributes[:hello]
    end
    
  end
  
end
