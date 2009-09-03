puts ''
if ENV['REMOTE_TESTS'] =~ /(yes|y|true|t)/i
  puts '*****'
  puts '** Testing will be performed against the remote server.'
  puts '*****'
  $perform_remote_tests = true
else
  puts 'Testing will be performed against mocked responses.'
  $perform_remote_tests = false
end
puts ''

def use_remote_server?
  $perform_remote_tests
end