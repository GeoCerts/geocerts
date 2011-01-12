require 'test_helper'

class GeoCerts::AgreementTest < Test::Unit::TestCase
  
  context 'GeoCerts::Agreement (using the API)' do
    
    context 'user agreement' do
      
      should 'return a GeoCerts::Agreement' do
        VCR.use_cassette('product_agreement') do
          assert_kind_of GeoCerts::Agreement,
            GeoCerts::Product.find('Q').user_agreement
        end
      end
      
      should 'contain the server-provided agreement text' do
        VCR.use_cassette('product_agreement') do
          text = GeoCerts::Product.find('Q').user_agreement.text
          assert_match(/SSL Certificate Subscriber Agreement/, text)
        end
      end
      
      should 'return an error for an unrecognized product code' do
        VCR.use_cassette('product_agreement_404') do
          assert_responds_with_exception(GeoCerts::UnprocessableEntity, -90000) do
            GeoCerts::Product.new(:sku => 'BAD').user_agreement
          end
        end
      end
      
    end
    
  end
  
end
