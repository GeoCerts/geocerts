require 'test_helper'

class GeoCertsTest < Test::Unit::TestCase
  
  context 'GeoCerts' do
    
    should 'use the sandbox host' do
      GeoCerts.sandbox = true
      assert_equal('sandbox.geocerts.com', GeoCerts.host)
    end
    
    should 'use the production host' do
      GeoCerts.sandbox = false
      assert_equal('www.geocerts.com', GeoCerts.host)
    end
    
  end
  
end
