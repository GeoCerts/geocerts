require 'test_helper'

class GeoCertsTest < Test::Unit::TestCase
  
  context 'GeoCerts' do
    
    should 'use the sandbox host' do
      setting(GeoCerts, :sandbox, :to => true) do
        assert_equal('sandbox.geocerts.com', GeoCerts.host)
      end
    end
    
    should 'use the production host' do
      setting(GeoCerts, :sandbox, :to => false) do
        assert_equal('www.geocerts.com', GeoCerts.host)
      end
    end
    
    should 'use the given host' do
      setting(GeoCerts, :host, :to => 'test.com', :back => nil) do
        assert_equal('test.com', GeoCerts.host)
      end
      
      setting(GeoCerts, :host, :to => 'test.com:8000', :back => nil) do
        assert_equal('test.com:8000', GeoCerts.host)
      end
    end
    
  end
  
end
