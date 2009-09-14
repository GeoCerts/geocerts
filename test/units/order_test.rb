require 'test_helper'

class OrderTest < Test::Unit::TestCase
  
  context 'Order' do
    
    should 'generate a collection of GeoCerts::Warnings' do
      order = GeoCerts::Order.new({:warnings => {
        :warning => [
          {:code => '123', :message => 'testing'}
        ]}
      })
      assert !order.warnings.empty?
      assert_equal 1, order.warnings.size
      assert order.warnings.all? { |warning| warning.kind_of?(GeoCerts::Warning) }
    end
    
  end
  
end
