module Responses
  
  module Hello
    
    Hello = <<-XML
HTTP/1.1 200 OK
Content-Type: application/xml; charset=utf-8
Connection: keep-alive
Vary: Accept-Encoding
Status: 200
Content-Length: 67

<?xml version="1.0" encoding="UTF-8"?>
<hello>test message</hello>
XML
    
  end
  
end
