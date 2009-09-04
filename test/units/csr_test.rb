require 'test_helper'

class CSRTest < Test::Unit::TestCase
  
  context 'CSR' do
    
    [ :body,
      :common_name,
      :city,
      :state,
      :country,
      :organization,
      :organizational_unit ].each do |method|
        
      should "respond to #{method}" do
        assert_respond_to(GeoCerts::CSR.new, method)
      end
      
      should "properly set the #{method}" do
        assert_equal('test', GeoCerts::CSR.new(method => 'test').__send__(method))
      end
      
    end
    
  end
  
end
