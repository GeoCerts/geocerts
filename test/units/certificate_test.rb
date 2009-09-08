require 'test_helper'

class CertificateTest < Test::Unit::TestCase
  
  context 'Certificate' do
    
    context 'trial' do
      
      should 'be true when set to "true"' do
        assert_kind_of(TrueClass, GeoCerts::Certificate.new(:trial => 'true').trial)
      end
      
      should 'be false' do
        assert_kind_of(FalseClass, GeoCerts::Certificate.new(:trial => 'false').trial)
      end
      
    end
    
  end
  
end
