require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'fakeweb'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'geo_certs'

# Load any initializers for testing.
Dir[File.dirname(__FILE__) + '/config/initializers/**/*.rb'].sort.each do |initializer|
  require initializer
end

class Test::Unit::TestCase
end
