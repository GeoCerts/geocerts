require 'test_helper'

class GeoCerts::Order::AdministratorTest < Test::Unit::TestCase
  
  context 'Order::Administrator' do
    
    [ :email,
      :first_name,
      :last_name,
      :phone ].each do |method|
        
      should "respond to #{method}" do
        assert_respond_to(GeoCerts::Order::Administrator.new, method)
      end
      
      should "properly set the #{method}" do
        assert_equal('test', GeoCerts::Order::Administrator.new(method => 'test').__send__(method))
      end
      
    end
    
  end
  
end
