require 'yaml'

begin
  credentials         = YAML.load_file(File.dirname(__FILE__) + '/../config/test_credentials.yml')
  GeoCerts.login      = credentials['login']
  GeoCerts.api_token  = credentials['api_token']
rescue Errno::ENOENT, LoadError
  puts '===='
  puts '= An error occurred:'
  puts '= You must set up your test_credentials.yml file.'
  puts '===='
  exit(1)
end
