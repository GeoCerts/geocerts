require 'test_helper'

class GeoCerts::HelloTest < Test::Unit::TestCase
  
  context 'GeoCerts::Hello (using the API)' do
    
    context 'message' do
      
      should 'return a GeoCerts::Hello' do
        managed_server_request :post, %r{/hello.xml.*}, :response => Responses::Hello::Hello do
          assert_kind_of(GeoCerts::Hello, GeoCerts::Hello.message('test message'))
        end
      end
      
      should 'return the message' do
        managed_server_request :post, %r{/hello.xml.*}, :response => Responses::Hello::Hello do
          assert_equal('test message', GeoCerts::Hello.message('test message').hello)
          assert_equal('test message', GeoCerts::Hello.message('test message').result)
        end
      end
      
    end
    
  end
  
end
