require 'test_helper'

class GeoCerts::FraudScoreTest < Test::Unit::TestCase

  context 'Order (using the API)' do
    
    context 'query' do
      should 'properly populate the data' do
        exclusively_mocked_request :post, %r{/fraud_score.xml}, :response => GeoCerts::Responses::FraudScore::Query do
          score = GeoCerts::FraudScore.query(Factory.attributes_for(:fraud_score))
          assert_equal '1.2.3.4', score.ip
          assert_equal 'Orlando', score.city
          assert_equal 'FL', score.region
          assert_equal '32801', score.postal_code
          assert_equal 'US', score.country
          assert_equal nil, score.domain
          assert_equal nil, score.bin
          assert_equal '', score.bin_name
          assert_equal '', score.bin_phone
          assert_equal nil, score.phone
          assert_equal nil, score.forwarded_ip
          assert_equal nil, score.email
          assert_equal nil, score.username
          assert_equal nil, score.password
          assert_equal nil, score.shipping_address
          assert_equal nil, score.shipping_city
          assert_equal nil, score.shipping_region
          assert_equal nil, score.shipping_postal_code
          assert_equal nil, score.shipping_country
          assert_equal nil, score.transaction_id
          assert_equal nil, score.session_id
          assert_equal nil, score.user_agent
          assert_equal nil, score.accept_language
          assert_equal true, score.country_match
          assert_equal 'US', score.country_code
          assert_equal false, score.high_risk_country
          assert_equal 20.0, score.distance
          assert_equal 'FL', score.ip_region
          assert_equal 'Orlando', score.ip_city
          assert_equal 28.5341, score.ip_latitude
          assert_equal -81.1647, score.ip_longitude
          assert_equal 'PowerOne Internet LLC', score.ip_isp
          assert_equal 'CoLabs', score.ip_org
          assert_equal false, score.anonymous_proxy
          assert_equal 0.0, score.proxy_score
          assert_equal false, score.transparent_proxy
          assert_equal false, score.freemail
          assert_equal false, score.carder_email
          assert_equal false, score.high_risk_username
          assert_equal false, score.high_risk_password
          assert_equal false, score.bin_match
          assert_equal '', score.bin_country
          assert_equal 'NA', score.bin_name_match
          assert_equal '', score.bin_name
          assert_equal false, score.bin_phone_match
          assert_equal '', score.bin_phone
          assert_equal false, score.phone_in_billing_location
          assert_equal false, score.ship_forward
          assert_equal false, score.city_postal_match
          assert_equal false, score.ship_city_postal_match
          assert_equal 'This order is low risk', score.explanation
          assert_equal 0.1, score.risk_score
          assert_equal 975, score.queries_remaining
          assert_equal '', score.error
        end
      end
    end

  end

end

