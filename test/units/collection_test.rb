require 'test_helper'

class CollectionTest < Test::Unit::TestCase
  
  context 'GeoCerts::Collection' do
    
    should 'carry a start_at attribute' do
      collection  = GeoCerts::Collection.new
      time        = Time.now
      assert_respond_to(collection, :start_at=)
      assert_respond_to(collection, :start_at)
      collection.start_at = time
      assert_equal(time, collection.start_at)
    end
    
    should 'carry an end_at attribute' do
      collection  = GeoCerts::Collection.new
      time        = Time.now
      assert_respond_to(collection, :end_at=)
      assert_respond_to(collection, :end_at)
      collection.end_at = time
      assert_equal(time, collection.end_at)
    end
    
  end
  
end
