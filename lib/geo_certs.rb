require 'relax'
require 'cgi'
require 'geo_certs/api'

module GeoCerts
  
  def self.api_token
    @@api_token ||= nil
  end
  
  def self.api_token=(token)
    @@api_token = token
  end
  
  def self.login
    @@login ||= login
  end
  
  def self.login=(login)
    @@login = login
  end
  
  def self.api
    @@api = API.new({:version => 1}, {:credentials => [login, api_token]})
  end
  
end
