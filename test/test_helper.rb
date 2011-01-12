$:.unshift(File.expand_path('..', __FILE__))
$:.unshift(File.expand_path('../../lib', __FILE__))

require 'bundler'
Bundler.setup

require 'geo_certs'
require 'shoulda'
require 'mocha'
require 'factory_girl'
require 'factories'
require 'vcr'

# Load any initializers for testing.
Dir[File.expand_path('../config/initializers/**/*.rb', __FILE__)].sort.each do |initializer|
  require initializer
end

class Test::Unit::TestCase
  
  def managed_server_request(method, path, options = {}, &block)
    case path
    when String
      uri           = URI.parse(GeoCerts::API::ENDPOINT.gsub(':host', GeoCerts.host).gsub(':version', '1') + path)
      uri.user      = GeoCerts.partner_id
      uri.password  = GeoCerts.api_token
      FakeWeb.register_uri(method, uri.to_s, options)
    when Regexp
      FakeWeb.register_uri(method, path, options)
    end unless use_remote_server?
    
    yield
  ensure
    FakeWeb.clean_registry
  end
  
  def exclusively_mocked_request(method, url, options = {}, &block)
    managed_server_request(method, url, options, &block) unless use_remote_server?
  end
  
  def assert_responds_with_exception(exception, *error_codes, &block)
    raised = false
    begin
      yield
    rescue exception => e
      return unless e.respond_to?(:errors)
      error_codes.each do |code|
        assert e.errors.any? { |error| error.code == code }, "No error was returned with Code #{code}\n#{e.errors.inspect}"
      end
      raised = true
    rescue Exception => e
      flunk "A #{e} exception was thrown, rather than the #{exception} exception expected"
    end
    flunk "A #{exception} exception failed to be thrown" unless raised
  end
  
  def assert_responds_without_exception(exception, *error_codes, &block)
    begin
      yield
      assert true # no exceptions were raised
    rescue exception => e
      flunk "A #{exception} exception was unexpectedly raised"
    rescue Exception
      assert true # it wasn't the watched for exception.
    end
  end
  
  def setting(object, method, options = {})
    original_value = object.send(method)
    object.send("#{method}=", options[:to])
    yield if block_given?
  ensure
    object.send("#{method}=", options.has_key?(:back) ? options[:back] : original_value)
  end
  
end
