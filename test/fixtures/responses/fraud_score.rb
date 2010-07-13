module GeoCerts
  module Responses
    module FraudScore
      Query = <<-RESPONSE
HTTP/1.1 200 OK 
Etag: "94d6a7687963f059aa9249300d721ef1"
Connection: Keep-Alive
Content-Type: application/xml; charset=utf-8
Date: Tue, 13 Jul 2010 21:57:44 GMT
X-Runtime: 444
Content-Length: 1439
Cache-Control: private, max-age=0, must-revalidate

<?xml version="1.0" encoding="UTF-8"?>
<fraud-score>
  <country-match type="boolean">true</country-match>
  <country-code>US</country-code>
  <high-risk-country type="boolean">false</high-risk-country>
  <distance type="integer">20</distance>
  <ip-region>FL</ip-region>
  <ip-city>Orlando</ip-city>
  <ip-latitude type="float">28.5341</ip-latitude>
  <ip-longitude type="float">-81.1647</ip-longitude>
  <ip-isp>PowerOne Internet LLC</ip-isp>
  <ip-org>CoLabs</ip-org>
  <anonymous-proxy type="boolean">false</anonymous-proxy>
  <proxy-score type="float">0.0</proxy-score>
  <transparent-proxy type="boolean"></transparent-proxy>
  <freemail type="boolean">false</freemail>
  <carder-email type="boolean"></carder-email>
  <high-risk-username type="boolean"></high-risk-username>
  <high-risk-password type="boolean"></high-risk-password>
  <bin-match>NA</bin-match>
  <bin-country></bin-country>
  <bin-name-match>NA</bin-name-match>
  <bin-name></bin-name>
  <bin-phone-match>NA</bin-phone-match>
  <bin-phone></bin-phone>
  <phone-in-billing-location>false</phone-in-billing-location>
  <ship-forward></ship-forward>
  <city-postal-match type="boolean">false</city-postal-match>
  <ship-city-postal-match type="boolean"></ship-city-postal-match>
  <explanation>This order is low risk</explanation>
  <risk-score type="float">0.1</risk-score>
  <queries-remaining type="integer">975</queries-remaining>
  <error></error>
</fraud-score>
RESPONSE
    end
  end
end
