require 'yaml'

begin
  credentials         = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/../test_credentials.yml'))
  GeoCerts.partner_id = credentials['partner_id']
  GeoCerts.api_token  = credentials['api_token']
  GeoCerts.sandbox    = true
rescue Errno::ENOENT, LoadError
  puts '===='
  puts '= An error occurred:'
  puts '= You must set up your test_credentials.yml file.'
  puts '===='
  exit(1)
end
