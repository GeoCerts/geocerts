module Responses
  
  module Event
    
    All = %|HTTP/1.1 200 OK 
Date: Tue, 08 Sep 2009 20:27:15 GMT 
Server: Mongrel 1.1.3 
Status: 200 OK 
Cache-Control: no-cache 
Content-Type: application/xml; charset=utf-8 
Content-Length: 538
Vary: Accept-Encoding 
Connection: close 

<?xml version="1.0" encoding="UTF-8"?>
<events start_at="2009-01-01T00:00:00Z" end_at="2009-09-08T16:27:15-04:00">
  <event>
    <event-id>795652</event-id>
    <order-id type="integer">422800</order-id>
    <name>Approver Confirmed</name>
    <created-at type="datetime">2009-08-12T16:38:14-04:00</created-at>
  </event>
  <event>
    <event-id>795651</event-id>
    <order-id type="integer">422801</order-id>
    <name>Approver Confirmed</name>
    <created-at type="datetime">2009-08-12T16:08:12-04:00</created-at>
  </event>
</events>
|
    
    Order = %|HTTP/1.1 200 OK 
Date: Tue, 08 Sep 2009 20:27:15 GMT 
Server: Mongrel 1.1.3 
Status: 200 OK 
Cache-Control: no-cache 
Content-Type: application/xml; charset=utf-8 
Content-Length: 538
Vary: Accept-Encoding 
Connection: close 

<?xml version="1.0" encoding="UTF-8"?>
<events start_at="2009-01-01T00:00:00Z" end_at="2009-09-08T16:27:15-04:00">
  <event>
    <event-id>795652</event-id>
    <order-id type="integer">422815</order-id>
    <name>Approver Confirmed</name>
    <created-at type="datetime">2009-08-12T16:38:14-04:00</created-at>
  </event>
  <event>
    <event-id>795651</event-id>
    <order-id type="integer">422815</order-id>
    <name>Approver Confirmed</name>
    <created-at type="datetime">2009-08-12T16:08:12-04:00</created-at>
  </event>
</events>|
    
  end
  
end
