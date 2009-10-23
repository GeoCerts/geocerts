require 'test_helper'

class OrderTest < Test::Unit::TestCase

  context 'Order' do

    should 'generate a collection of GeoCerts::Warnings' do
      order = Factory.build(:order, {
        :warnings => {
          :warning => [
            {:code => '123', :message => 'testing'}
          ]}
      })
      assert        !order.warnings.empty?
      assert_equal  1, order.warnings.size
      assert        order.warnings.all? { |warning| warning.kind_of?(GeoCerts::Warning) }
    end

    should 'accept a String for a CSR and assume it to be a CSR body when matches "-----BEGIN CERTIFICATE REQUEST-----"' do
      body  = Factory.attributes_for(:csr)[:body]
      order = Factory.build(:order, :csr => body)
      assert_equal(body, order.csr.body)
    end

    should 'accept a String for a CSR and assume it to be a CSR body when matches "-----BEGIN NEW CERTIFICATE REQUEST-----"' do
      body  = "-----BEGIN NEW CERTIFICATE REQUEST-----\nABCD1234\n-----END NEW CERTIFICATE REQUEST-----\n"
      order = Factory.build(:order, :csr => body)
      assert_equal(body, order.csr.body)
    end

    should 'ignore random Strings for a CSR' do
      body  = 'NOT A VALID CSR'
      order = Factory.build(:order, :csr => body)
      assert_nil(order.csr)
    end

    should 'accept a GeoCerts::CSR for a CSR' do
      csr   = Factory.build(:csr)
      order = Factory.build(:order, :csr => csr)
      assert_equal(csr, order.csr)
    end

    should 'accept a String for a Product and assume it to be a product SKU' do
      sku   = Factory.attributes_for(:product)[:sku]
      GeoCerts::Product.stubs(:find).with(sku).returns(Factory.build(:product, :sku => sku))
      order = Factory.build(:order, :product => sku)
      assert_not_nil(order.product)
      assert_equal(sku, order.product.sku)
    end

    should 'accept a GeoCerts::Product for a Product' do
      product = Factory.build(:product)
      order   = Factory.build(:order, :product => product)
      assert_equal(product, order.product)
    end

  end

end
