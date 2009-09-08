require 'test_helper'

class GeoCerts::AgreementTest < Test::Unit::TestCase
  
  context 'GeoCerts::Agreement (using the API)' do
    
    context 'user agreement' do
      
      should 'return a GeoCerts::Agreement' do
        managed_server_request :get, 'https://api-test.geocerts.com/1/products.xml', :response => Responses::Product::All do
          managed_server_request :get, 'https://api-test.geocerts.com/1/products/QUICKSSL/agreement.xml', :response => Responses::Agreement::Agreement do
            assert_kind_of(GeoCerts::Agreement, GeoCerts::Product.find('Q').user_agreement)
          end
        end
      end
      
      should 'contain the server-provided agreement text' do
        managed_server_request :get, 'https://api-test.geocerts.com/1/products.xml', :response => Responses::Product::All do
          managed_server_request :get, 'https://api-test.geocerts.com/1/products/QUICKSSL/agreement.xml', :response => Responses::Agreement::Agreement do
            text = GeoCerts::Product.find('Q').user_agreement.text
            assert_match(/GeoTrust\(R\) SSL Certificate Subscriber Agreement/, text)
            assert_match(/YOU MUST READ THIS GEOTRUST SSL CERTIFICATE SUBSCRIBER AGREEMENT/, text)
            assert_match(/GeoTrust SSL Certificate Subscriber Agreement Version 2.0/, text)
          end
        end
      end
      
      should 'return an error for an unrecognized product code' do
        managed_server_request :get, 'https://api-test.geocerts.com/1/products/BADPRODUCTCODE/agreement.xml', :response => Responses::Agreement::UnrecognizedProduct do
          assert_responds_with_exception(GeoCerts::UnprocessableEntity, -90000) do
            GeoCerts::Product.new(:sku => 'BAD', :code => 'BADPRODUCTCODE').user_agreement
          end
        end
      end
      
    end
    
  end
  
end
