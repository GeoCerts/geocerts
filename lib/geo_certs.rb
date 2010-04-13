require 'relax'
require 'cgi'
require 'geo_certs/api'

##
# To properly configure the GeoCerts library, you must provide your partner ID and api token:
# 
#   GeoCerts.partner_id = 'ex4Mpl3'
#   GeoCerts.api_token  = 'abc123DEF456gHi...'
# 
# After that, most interaction is performed through other objects within the library, such
# as GeoCerts::Order, GeoCerts::Certificate, GeoCerts::CSR, etc.
# 
module GeoCerts
  
  def self.api_token
    @@api_token ||= nil
  end
  
  def self.api_token=(token)
    @@api_token = token
  end
  
  def self.partner_id
    @@partner_id ||= partner_id
  end
  
  def self.partner_id=(partner_id)
    @@partner_id = partner_id
  end
  
  def self.api # :nodoc:
    @@api = API.new({:version => 1}, {:credentials => [partner_id, api_token]})
  end
  
  def self.escape(value) # :nodoc:
    value ? CGI.escape(value.to_s) : nil
  end
  
end
