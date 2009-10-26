module Responses
  
  module Product
    
    All = %|HTTP/1.1 200 OK 
Date: Tue, 08 Sep 2009 19:34:48 GMT 
Server: Mongrel 1.1.3 
Status: 200 OK 
Cache-Control: no-cache 
Content-Type: application/xml; charset=utf-8 
Content-Length: 1751 
Vary: Accept-Encoding 
Connection: close 

<?xml version="1.0" encoding="UTF-8"?>
<products>
  <product>
    <name>QuickSSL</name>
    <sku>Q</sku>
    <max-years type="integer">6</max-years>
  </product>
  <product>
    <name>QuickSSL Premium</name>
    <sku>QP</sku>
    <max-years type="integer">6</max-years>
  </product>
  <product>
    <name>True BusinessID</name>
    <sku>TBID</sku>
    <max-years type="integer">5</max-years>
  </product>
  <product>
    <name>Wildcard SSL</name>
    <sku>TW</sku>
    <max-years type="integer">5</max-years>
  </product>
  <product>
    <name>True BizID Extended Validation</name>
    <sku>EV</sku>
    <max-years type="integer">2</max-years>
  </product>
  <product>
    <name>Power Server ID</name>
    <sku>PSID</sku>
    <max-years type="integer">6</max-years>
  </product>
  <product>
    <name>True Biz Multi-Domain 10</name>
    <sku>TBIDMD10</sku>
    <max-years type="integer">5</max-years>
  </product>
  <product>
    <name>True Biz Multi-Domain 15</name>
    <sku>TBIDMD15</sku>
    <max-years type="integer">5</max-years>
  </product>
  <product>
    <name>True Biz Multi-Domain 20</name>
    <sku>TBIDMD20</sku>
    <max-years type="integer">5</max-years>
  </product>
  <product>
    <name>True Biz Multi-Domain 25</name>
    <sku>TBIDMD25</sku>
    <max-years type="integer">5</max-years>
  </product>
  <product>
    <name>Free Trial (QP)</name>
    <sku>T</sku>
    <max-years type="integer">1</max-years>
  </product>
</products>
|
    
  end
  
end
