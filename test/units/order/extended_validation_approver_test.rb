require 'test_helper'

class GeoCerts::Order::ExtendedValidationApproverTest < Test::Unit::TestCase
  
  context 'Order::ExtendedValidationApprover' do
    
    [ :email,
      :first_name,
      :last_name,
      :phone ].each do |method|
        
      should "respond to #{method}" do
        assert_respond_to(GeoCerts::Order::ExtendedValidationApprover.new, method)
      end
      
      should "properly set the #{method}" do
        assert_equal('test', GeoCerts::Order::ExtendedValidationApprover.new(method => 'test').__send__(method))
      end
      
    end
    
  end
  
end
