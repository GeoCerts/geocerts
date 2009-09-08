require 'test_helper'

class GeoCerts::EventTest < Test::Unit::TestCase
  
  context 'GeoCerts::Event (using the API)' do
    
    context 'all' do
      
      should 'return a collection of GeoCerts::Events' do
        managed_server_request :get, 'https://api-test.geocerts.com/1/events.xml', :response => Responses::Event::All do
          events = GeoCerts::Event.all
          assert_kind_of(GeoCerts::Collection, events)
          assert events.all? { |event| event.kind_of?(GeoCerts::Event) }
        end
      end
      
      should 'return 2 events' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/events.xml', :response => Responses::Event::All do
          assert_equal(2, GeoCerts::Event.all.size)
        end
      end
      
      should 'properly populate the events' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/events.xml', :response => Responses::Event::All do
          event = GeoCerts::Event.all.first
          assert_equal(795652,                                      event.id)
          assert_equal(422800,                                      event.order_id)
          assert_equal('Approver Confirmed',                        event.name)
          assert_equal(DateTime.parse('2009-08-12T16:38:14-04:00'), event.created_at)
        end
      end
      
    end
    
    context 'all for an order' do
      
      setup do
        managed_server_request :get, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::All do
          @order_id = GeoCerts::Order.all.first.id
        end
      end
      
      should 'return a collection of GeoCerts::Events' do
        managed_server_request :get, "https://api-test.geocerts.com/1/orders/#{@order_id}/events.xml", :response => Responses::Event::Order do
          events = GeoCerts::Event.for_order(@order_id)
          assert_kind_of(GeoCerts::Collection, events)
          assert events.all? { |event| event.kind_of?(GeoCerts::Event) }
        end
      end
      
      should 'all reference the same order' do
        managed_server_request :get, "https://api-test.geocerts.com/1/orders/#{@order_id}/events.xml", :response => Responses::Event::Order do
          assert GeoCerts::Event.for_order(@order_id).all? { |event| event.order_id == @order_id }
        end
      end
      
      should 'return 2 events' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/orders/422815/events.xml', :response => Responses::Event::Order do
          assert_equal(2, GeoCerts::Event.for_order(422815).size)
        end
      end
      
      should 'properly populate the events' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/orders/422815/events.xml', :response => Responses::Event::Order do
          event = GeoCerts::Event.for_order(422815).first
          assert_equal(795652,                                      event.id)
          assert_equal(422815,                                      event.order_id)
          assert_equal('Approver Confirmed',                        event.name)
          assert_equal(DateTime.parse('2009-08-12T16:38:14-04:00'), event.created_at)
        end
      end
      
      should 'be accessible via a GeoCerts::Order' do
        exclusively_mocked_request :get, "https://api-test.geocerts.com/1/orders/422815.xml", :response => Responses::Order::Order do
          exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/orders/422815/events.xml', :response => Responses::Event::Order do
            assert_kind_of(GeoCerts::Event, GeoCerts::Order.find(422815).events.first)
          end
        end
      end
      
    end
    
  end
  
end
