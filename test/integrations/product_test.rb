require 'test_helper'

class GeoCerts::ProductTest < Test::Unit::TestCase
  
  context 'GeoCerts::Product (using the API)' do
    
    context 'all' do
      
      should 'return a collection of GeoCerts::Products' do
        managed_server_request :get, '/products.xml', :response => Responses::Product::All do
          products = GeoCerts::Product.all
          assert_kind_of(GeoCerts::Collection, products)
          assert products.all? { |product| product.kind_of?(GeoCerts::Product) }
        end
      end
      
      should 'return 11 products' do
        exclusively_mocked_request :get, '/products.xml', :response => Responses::Product::All do
          assert_equal(11, GeoCerts::Product.all.size)
        end
      end
      
      should 'properly populate the products' do
        exclusively_mocked_request :get, '/products.xml', :response => Responses::Product::All do
          product = GeoCerts::Product.all.first
          assert_equal('QuickSSL',  product.name)
          assert_equal('Q',         product.sku)
          assert_equal(6,           product.max_years)
        end
      end
      
    end
    
    context 'find' do
      
      should 'return a GeoCerts::Product by SKU' do
        managed_server_request :get, '/products.xml', :response => Responses::Product::All do
          assert_equal('Q', GeoCerts::Product.find('Q').sku)
        end
      end
      
      should 'raise a GeoCerts::ResourceNotFound exception' do
        managed_server_request :get, '/products.xml', :response => Responses::Product::All do
          assert_responds_with_exception(GeoCerts::ResourceNotFound) do
            GeoCerts::Product.find('BADSKU')
          end
        end
      end
      
    end
    
    context 'find_by_sku' do
      
      should 'return a GeoCerts::Product by SKU' do
        managed_server_request :get, '/products.xml', :response => Responses::Product::All do
          assert_equal('Q', GeoCerts::Product.find_by_sku('Q').sku)
        end
      end
      
      should 'raise a GeoCerts::ResourceNotFound exception' do
        managed_server_request :get, '/products.xml', :response => Responses::Product::All do
          assert_responds_without_exception(GeoCerts::ResourceNotFound) do
            assert_nil GeoCerts::Product.find_by_sku('BADSKU')
          end
        end
      end
      
    end
    
  end
  
end
