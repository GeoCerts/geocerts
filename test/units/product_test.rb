require 'test_helper'

class ProductTest < Test::Unit::TestCase
  
  context 'Product' do
    
    [ :name, :sku, :max_years, :code ].each do |method|
        
      should "respond to #{method}" do
        assert_respond_to(GeoCerts::Product.new, method)
      end
      
      should "properly set the #{method}" do
        assert_equal('test', GeoCerts::Product.new(method => 'test').__send__(method))
      end
      
    end
    
  end
  
end
