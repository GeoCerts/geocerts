require 'test_helper'

class GeoCerts::APITest < Test::Unit::TestCase
  
  context 'GeoCerts::API' do
    
    should 'be unauthorized' do
      managed_server_request :get, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Unauthorized do
        assert_responds_with_exception(GeoCerts::Unauthorized) do
          GeoCerts::Order.all
        end
      end
    end
    
    should 'raise a GeoCerts::RequestTimeout error when the connection times out' do
      exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/orders.xml', :exception => Timeout::Error do
        assert_responds_with_exception(GeoCerts::RequestTimeout) do
          GeoCerts::Order.all
        end
      end
    end
    
    should 'raise a GeoCerts::RequestTimeout error when the connection gets reset' do
      exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/orders.xml', :exception => Errno::ECONNRESET do
        assert_responds_with_exception(GeoCerts::ConnectionError) do
          GeoCerts::Order.all
        end
      end
    end
    
  end
  
end
