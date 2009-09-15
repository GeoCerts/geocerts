require 'test_helper'

class GeoCerts::OrderTest < Test::Unit::TestCase

  context 'Order (using the API)' do
    
    context 'all' do
      
      should 'return a collection of GeoCerts::Orders' do
        managed_server_request :get, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::All do
          assert GeoCerts::Order.all.all? { |item| item.kind_of?(GeoCerts::Order) }
        end
      end
      
      should 'return three orders' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::All do
          assert_equal(3, GeoCerts::Order.all.size)
        end
      end
      
      should 'properly populate the order data' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::All do
          order = GeoCerts::Order.all.first
          assert_equal(422815,                order.id)
          assert_equal('srv02.wavepath.com',  order.domain)
          assert_equal('93520',               order.geotrust_order_id)
          assert_equal('Complete',            order.status_major)
          assert_equal('Order Complete',      order.status_minor)
          assert_equal(1,                     order.years)
          assert_equal(1,                     order.licenses)
          assert_equal(DateTime.parse('2009-08-12T16:43:02-04:00'), order.created_at)
          assert_equal(DateTime.parse('2009-08-12T16:45:06-04:00'), order.completed_at)
          assert_equal(false,                 order.trial)
          assert_equal(false,                 order.renewal)
          assert_equal('',                    order.sans)
          assert_equal('COMPLETED',           order.state)
          assert_equal(69.00,                 order.total_price)
          assert_equal(false,                 order.pending_audit)
        end
      end
      
      should 'set the end at time' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::All do
          assert_equal DateTime.parse('2009-09-03T11:56:44-04:00'), GeoCerts::Order.all.end_at
        end
      end
      
      should 'set the start at time' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::All do
          assert_equal DateTime.parse('2009-08-04T11:56:44-04:00'), GeoCerts::Order.all.start_at
        end
      end
      
      should 'modify the query range' do
        managed_server_request :get, 'https://api-test.geocerts.com/1/orders.xml?end_at=2009-01-02T00:00:00+00:00&start_at=2009-01-01T00:00:00+00:00', :response => Responses::Order::All do
          GeoCerts::Order.all(:start_at => DateTime.parse('2009-01-01T00:00:00Z'), :end_at => DateTime.parse('2009-01-02T00:00:00Z'))
        end
      end
      
    end
    
    context 'find' do
      
      setup do
        managed_server_request :get, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::All do
          @order_id = GeoCerts::Order.all.first.id
        end
      end
      
      should 'return a GeoCerts::Order' do
        managed_server_request :get, "https://api-test.geocerts.com/1/orders/#{@order_id}.xml", :response => Responses::Order::Order do
          order = GeoCerts::Order.find(@order_id)
          assert_kind_of(GeoCerts::Order, order)
          assert_equal(@order_id, order.id)
        end
      end
      
      should 'properly populate the order data' do
        exclusively_mocked_request :get, "https://api-test.geocerts.com/1/orders/422815.xml", :response => Responses::Order::Order do
          order = GeoCerts::Order.find(422815)
          assert_equal(422815,                order.id)
          assert_equal('srv02.wavepath.com',  order.domain)
          assert_equal('93520',               order.geotrust_order_id)
          assert_equal('Complete',            order.status_major)
          assert_equal('Order Complete',      order.status_minor)
          assert_equal(1,                     order.years)
          assert_equal(1,                     order.licenses)
          assert_equal(DateTime.parse('2009-08-12T16:43:02-04:00'), order.created_at)
          assert_equal(DateTime.parse('2009-08-12T16:45:06-04:00'), order.completed_at)
          assert_equal(false,                 order.trial)
          assert_equal(false,                 order.renewal)
          assert_equal('',                    order.sans)
          assert_equal('COMPLETED',           order.state)
          assert_equal(69.00,                 order.total_price)
          assert_equal(false,                 order.pending_audit)
        end
      end
      
      should 'raise a ResourceNotFound error' do
        managed_server_request :get, 'https://api-test.geocerts.com/1/orders/999999999.xml', :response => Responses::InvalidOrderId do
          assert_responds_with_exception(GeoCerts::ResourceNotFound, -90004) do
            GeoCerts::Order.find(999999999)
          end
        end
      end
      
    end
    
    context 'find_by_id' do
      
      setup do
        managed_server_request :get, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::All do
          @order_id = GeoCerts::Order.all.first.id
        end
      end
      
      should 'return a GeoCerts::Order' do
        managed_server_request :get, "https://api-test.geocerts.com/1/orders/#{@order_id}.xml", :response => Responses::Order::Order do
          order = GeoCerts::Order.find_by_id(@order_id)
          assert_kind_of(GeoCerts::Order, order)
          assert_equal(@order_id, order.id)
        end
      end
      
      should 'properly populate the order data' do
        exclusively_mocked_request :get, "https://api-test.geocerts.com/1/orders/422815.xml", :response => Responses::Order::Order do
          order = GeoCerts::Order.find_by_id(422815)
          assert_equal(422815,                order.id)
          assert_equal('srv02.wavepath.com',  order.domain)
          assert_equal('93520',               order.geotrust_order_id)
          assert_equal('Complete',            order.status_major)
          assert_equal('Order Complete',      order.status_minor)
          assert_equal(1,                     order.years)
          assert_equal(1,                     order.licenses)
          assert_equal(DateTime.parse('2009-08-12T16:43:02-04:00'), order.created_at)
          assert_equal(DateTime.parse('2009-08-12T16:45:06-04:00'), order.completed_at)
          assert_equal(false,                 order.trial)
          assert_equal(false,                 order.renewal)
          assert_equal('',                    order.sans)
          assert_equal('COMPLETED',           order.state)
          assert_equal(69.00,                 order.total_price)
          assert_equal(false,                 order.pending_audit)
        end
      end
      
      should 'raise a ResourceNotFound error' do
        managed_server_request :get, 'https://api-test.geocerts.com/1/orders/999999999.xml', :response => Responses::InvalidOrderId do
          assert_responds_without_exception(GeoCerts::ResourceNotFound) do
            assert_nil GeoCerts::Order.find_by_id(999999999)
          end
        end
      end
      
    end
    
    context 'approvers' do
      
      should 'return a collection of GeoCerts::Emails' do
        managed_server_request :get, "https://api-test.geocerts.com/1/orders.xml;approvers?domain=geocerts.com", :response => Responses::Order::Approvers do
          approvers = GeoCerts::Order.approvers('geocerts.com')
          assert_kind_of(GeoCerts::Collection, approvers)
          assert(approvers.all? { |item| item.kind_of?(GeoCerts::Email) }, approvers.collect { |item| item.class.name }.join(", "))
        end
      end
      
      should 'contain expected addresses' do
        managed_server_request :get, "https://api-test.geocerts.com/1/orders.xml;approvers?domain=geocerts.com", :response => Responses::Order::Approvers do
          approvers = GeoCerts::Order.approvers('geocerts.com')
          %W( blank@geocerts.com
              admin@geocerts.com
              administrator@geocerts.com
              hostmaster@geocerts.com
              root@geocerts.com
              ssladmin@geocerts.com
              sysadmin@geocerts.com
              webmaster@geocerts.com
              info@geocerts.com
              is@geocerts.com
              it@geocerts.com
              mis@geocerts.com
              ssladministrator@geocerts.com
              sslwebmaster@geocerts.com
              postmaster@geocerts.com ).each do |address|
            assert(approvers.any? { |email| email.address == address }, "#{address} was not returned")
          end
        end
      end
      
    end
    
    context 'modify!' do
      
      should 'raise an error with an invalid state given' do
        managed_server_request :get, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::All do
          order = GeoCerts::Order.all.first
          managed_server_request :put, "https://api-test.geocerts.com/1/orders/#{order.id}.xml;modify?order[state]=BAD", :response => Responses::Order::BadModifyResponse do
            assert_responds_with_exception(GeoCerts::UnprocessableEntity, -90003) do
              order.modify!('BAD')
            end
          end
        end
      end
      
      should 'raise an error when modifying an order which cannot be modified' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::All do
          order = GeoCerts::Order.all.first
          exclusively_mocked_request :put, "https://api-test.geocerts.com/1/orders/#{order.id}.xml;modify?order[state]=CANCEL", :response => Responses::Order::WrongState do
            assert_responds_with_exception(GeoCerts::UnprocessableEntity, -90002) do
              order.modify!('CANCEL')
            end
          end
        end
      end
      
      should 'return a GeoCerts::Order when successful' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::All do
          order = GeoCerts::Order.all.first
          exclusively_mocked_request :put, "https://api-test.geocerts.com/1/orders/#{order.id}.xml;modify?order[state]=CANCEL", :response => Responses::Order::Order do
            order.modify!('CANCEL')
          end
        end
      end
      
    end
    
    context 'resend_approval_email!' do
      
      should 'respond with a GeoCerts::Order' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::All do
          order = GeoCerts::Order.all.first
          exclusively_mocked_request :post, "https://api-test.geocerts.com/1/orders/#{order.id}.xml;resend", :response => Responses::Order::Order do
            order.resend_approval_email!
          end
        end
      end
      
      should 'fail with errors' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::All do
          order = GeoCerts::Order.all.first
          exclusively_mocked_request :post, "https://api-test.geocerts.com/1/orders/#{order.id}.xml;resend", :response => Responses::GenericFailure do
            assert_responds_with_exception(GeoCerts::UnprocessableEntity, -12345) do
              order.resend_approval_email!
            end
          end
        end
      end
      
    end
    
    context 'change_approver_email!' do
      
      should 'respond with a GeoCerts::Order' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::All do
          order = GeoCerts::Order.all.first
          exclusively_mocked_request :put, "https://api-test.geocerts.com/1/orders/#{order.id}.xml;email?order[approver_email]=admin@example.com", :response => Responses::Order::Order do
            order.change_approver_email!('admin@example.com')
          end
        end
      end
      
      should 'fail with errors' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::All do
          order = GeoCerts::Order.all.first
          exclusively_mocked_request :put, "https://api-test.geocerts.com/1/orders/#{order.id}.xml;email?order[approver_email]=admin@example.com", :response => Responses::GenericFailure do
            assert_responds_with_exception(GeoCerts::UnprocessableEntity, -12345) do
              order.change_approver_email!('admin@example.com')
            end
          end
        end
      end
      
    end
    
    context 'create' do
      
      should 'return a GeoCerts::Order on success' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::Order do
          order = GeoCerts::Order.create(Factory.attributes_for(:order))
          assert_kind_of GeoCerts::Order, order
        end
      end
      
      should 'return a GeoCerts::Order on failure' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::GenericFailure do
          order = GeoCerts::Order.create(Factory.attributes_for(:order))
          assert_kind_of(GeoCerts::Order, order)
        end
      end
      
      should 'be a new_record? on failure' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::GenericFailure do
          order = GeoCerts::Order.create(Factory.attributes_for(:order))
          assert order.new_record?
        end
      end
      
      should 'populate errors on failure' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::GenericFailure do
          order = GeoCerts::Order.create(Factory.attributes_for(:order))
          assert !order.errors.empty?
        end
      end
      
      should 'return a GeoCerts::Order with warnings' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::OrderWithWarnings do
          order = GeoCerts::Order.create(Factory.attributes_for(:order))
          assert_not_nil(order.warnings)
          assert !order.warnings.empty?
          assert order.warnings.all? { |warning| warning.kind_of?(GeoCerts::Warning) }
        end
      end
      
    end
    
    context 'create!' do
      
      should 'return a GeoCerts::Order on success' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::Order do
          order = GeoCerts::Order.create!(Factory.attributes_for(:order))
          assert_kind_of GeoCerts::Order, order
        end
      end
      
      should 'raise GeoCerts::ResourceNotCreated on failure' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::GenericFailure do
          assert_responds_with_exception(GeoCerts::ResourceNotCreated) do
            GeoCerts::Order.create!(Factory.attributes_for(:order))
          end
        end
      end
      
    end
    
    # Instance methods...
    
    context 'save' do
      
      should 'return a GeoCerts::Order on success' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::Order do
          order = GeoCerts::Order.new(Factory.attributes_for(:order))
          assert_kind_of GeoCerts::Order, order.save
        end
      end
      
      should 'return false on failure' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::GenericFailure do
          order = GeoCerts::Order.new(Factory.attributes_for(:order))
          assert_equal(false, order.save)
        end
      end
      
      should 'be a new_record? on failure' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::GenericFailure do
          order = GeoCerts::Order.new(Factory.attributes_for(:order))
          order.save
          assert order.new_record?
        end
      end
      
      should 'populate errors on failure' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::GenericFailure do
          order = GeoCerts::Order.new(Factory.attributes_for(:order))
          order.save
          assert_not_nil(order.errors)
          assert(!order.errors.empty?)
        end
      end
      
      should 'return a GeoCerts::Order with warnings' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::OrderWithWarnings do
          order = GeoCerts::Order.new(Factory.attributes_for(:order))
          order.save
          assert_not_nil(order.warnings)
          assert !order.warnings.empty?
          assert order.warnings.all? { |warning| warning.kind_of?(GeoCerts::Warning) }
        end
      end
      
    end
    
    context 'save!' do
      
      should 'return a GeoCerts::Order on success' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::Order do
          order = GeoCerts::Order.new(Factory.attributes_for(:order))
          assert_kind_of GeoCerts::Order, order.save!
        end
      end
      
      should 'raise a GeoCerts::ResourceNotCreated on failure' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::GenericFailure do
          order = GeoCerts::Order.new(Factory.attributes_for(:order))
          assert_responds_with_exception(GeoCerts::ResourceNotCreated) do
            order.save!
          end
        end
      end
      
      should 'return a GeoCerts::Order with warnings' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::OrderWithWarnings do
          order = GeoCerts::Order.new(Factory.attributes_for(:order))
          order.save!
          assert_not_nil(order.warnings)
          assert !order.warnings.empty?
          assert order.warnings.all? { |warning| warning.kind_of?(GeoCerts::Warning) }
        end
      end
      
    end
    
    context 'validate' do
      
      should 'return a GeoCerts::Order on success' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml;validate', :response => Responses::Order::Validation do
          order = GeoCerts::Order.new(Factory.attributes_for(:order))
          assert_kind_of GeoCerts::Order, order.validate
        end
      end
      
      should 'contain properly decoded CSR information' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml;validate', :response => Responses::Order::Validation do
          order = GeoCerts::Order.new.validate
          assert_equal('www.example.com', order.csr.common_name)
          assert_equal('Atlanta',         order.csr.city)
          assert_equal('GA',              order.csr.state)
          assert_equal('US',              order.csr.country)
          assert_equal('GeoCerts Inc',    order.csr.organization)
          assert_equal('Internet',        order.csr.organizational_unit)
        end
      end
      
      should 'contain renewal information' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml;validate', :response => Responses::Order::Validation do
          order = GeoCerts::Order.new.validate
          assert_equal(true,              order.renewal_information.indicator)
          assert_equal(1,                 order.renewal_information.months)
          assert_equal('abC12De',         order.renewal_information.serial_number)
          assert_equal('1234ab',          order.renewal_information.order_id)
          assert_equal(DateTime.parse('2009-01-01T00:00:00Z'), order.renewal_information.expires_at)
        end
      end
      
      should 'return false on failure' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml;validate', :response => Responses::GenericFailure do
          order = GeoCerts::Order.new
          assert_equal(false, order.validate)
        end
      end
      
      should 'populate the order with errors on failure' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml;validate', :response => Responses::GenericFailure do
          order = GeoCerts::Order.new
          order.validate
          assert !order.errors.empty?
        end
      end
      
    end
    
    context 'validate!' do
      
      should 'return a GeoCerts::Order on success' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml;validate', :response => Responses::Order::Validation do
          assert_kind_of GeoCerts::Order, GeoCerts::Order.validate!
        end
      end
      
      should 'contain properly decoded CSR information' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml;validate', :response => Responses::Order::Validation do
          order = GeoCerts::Order.validate!
          assert_equal('www.example.com', order.csr.common_name)
          assert_equal('Atlanta',         order.csr.city)
          assert_equal('GA',              order.csr.state)
          assert_equal('US',              order.csr.country)
          assert_equal('GeoCerts Inc',    order.csr.organization)
          assert_equal('Internet',        order.csr.organizational_unit)
        end
      end
      
      should 'contain renewal information' do
        exclusively_mocked_request :post, 'https://api-test.geocerts.com/1/orders.xml;validate', :response => Responses::Order::Validation do
          order = GeoCerts::Order.validate!
          assert_equal(true,              order.renewal_information.indicator)
          assert_equal(1,                 order.renewal_information.months)
          assert_equal('abC12De',         order.renewal_information.serial_number)
          assert_equal('1234ab',          order.renewal_information.order_id)
          assert_equal(DateTime.parse('2009-01-01T00:00:00Z'), order.renewal_information.expires_at)
        end
      end
      
      should 'fail with errors' do
        managed_server_request :post, 'https://api-test.geocerts.com/1/orders.xml;validate', :response => Responses::GenericFailure do
          assert_responds_with_exception(GeoCerts::ResourceInvalid, -12345) do
            GeoCerts::Order.validate!
          end
        end
      end
      
    end
    
  end

end
