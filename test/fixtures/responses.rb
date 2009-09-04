module Responses
  
  BadRequest = %|
HTTP/1.1 400 Bad Request
Date: Thu, 03 Sep 2009 15:53:28 GMT
Server: Mongrel 1.1.3
Status: 400 Bad Request
Cache-Control: no-cache
Content-Type: application/xml; charset=utf-8
Content-Length: 143
Vary: Accept-Encoding
Connection: close

<?xml version="1.0" encoding="UTF-8"?>
<errors>
  <error>
    <code>-5000</code>
    <message>HTTPS is required</message>
  </error>
</errors>
|

  InvalidOrderId = %|HTTP/1.1 404 Not Found
Date: Thu, 03 Sep 2009 16:57:30 GMT
Server: Mongrel 1.1.3
Status: 404 Not Found
Cache-Control: no-cache
Content-Type: application/xml; charset=utf-8
Content-Length: 161
Vary: Accept-Encoding
Connection: close

<?xml version="1.0" encoding="UTF-8"?>
<errors>
  <error>
    <code>-90004</code>
    <message>Invalid order identifier requested</message>
  </error>
</errors>
|
  
  GenericFailure = %|HTTP/1.1 422 Unprocessable Entity
Date: Thu, 03 Sep 2009 16:57:30 GMT
Server: Mongrel 1.1.3
Status: 422 Unprocessable Entity
Cache-Control: no-cache
Content-Type: application/xml; charset=utf-8
Content-Length: 149
Vary: Accept-Encoding
Connection: close

<?xml version="1.0" encoding="UTF-8"?>
<errors>
  <error>
    <code>-12345</code>
    <message>Generic failure message</message>
  </error>
</errors>
|
  
end
