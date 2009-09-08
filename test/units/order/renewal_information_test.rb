require 'test_helper'

class GeoCerts::Order::RenewalInformationTest < Test::Unit::TestCase
  
  context 'GeoCerts::Order::RenewalInformation' do
    
    [ :months,
      :serial_number,
      :order_id,
      :expires_at ].each do |method|
        
        should "respond to #{method}" do
          assert_respond_to(GeoCerts::Order::RenewalInformation.new, method)
        end

        should "properly set the #{method}" do
          assert_equal('test', GeoCerts::Order::RenewalInformation.new(method => 'test').__send__(method))
        end
        
    end
    
    should 'respond to indicator' do
      assert_respond_to(GeoCerts::Order::RenewalInformation.new, :indicator)
    end
    
    should 'set the indicator to true' do
      assert_kind_of TrueClass, GeoCerts::Order::RenewalInformation.new(:indicator => 'true').indicator
    end
    
    should 'set the indicator to false' do
      assert_kind_of FalseClass, GeoCerts::Order::RenewalInformation.new(:indicator => 'false').indicator
    end
    
  end
  
end
