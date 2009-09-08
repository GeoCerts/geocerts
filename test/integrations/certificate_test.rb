require 'test_helper'

class GeoCerts::CertificateTest < Test::Unit::TestCase
  
  context 'Certificate (using the API)' do
    
    context 'all' do
      
      should 'return a collection of GeoCerts::Certificates' do
        managed_server_request :get, 'https://api-test.geocerts.com/1/certificates.xml', :response => Responses::Certificate::All do
          assert GeoCerts::Certificate.all.all? { |item| item.kind_of?(GeoCerts::Certificate) }
        end
      end
      
      should 'return two certificates' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/certificates.xml', :response => Responses::Certificate::All do
          assert_equal(2, GeoCerts::Certificate.all.size)
        end
      end
      
      should 'properly populate the certificate data' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/certificates.xml', :response => Responses::Certificate::All do
          certificate = GeoCerts::Certificate.all.first
          assert_equal(422815,                certificate.order_id)
          assert_equal('93520',               certificate.geotrust_order_id)
          assert_equal('Renewed',             certificate.status)
          assert_equal('www.example.com',     certificate.common_name)
          assert_equal('1E08',                certificate.serial_number)
          assert_equal('Atlanta',             certificate.city)
          assert_equal('Georgia',             certificate.state)
          assert_equal('US',                  certificate.country)
          assert_equal('GeoCerts',            certificate.organization)
          assert_equal('Internet',            certificate.organizational_unit)
          assert_equal('ssladmin@example.com',certificate.approver_email)
          assert_equal('test@example.com',    certificate.reissue_email)
          assert_equal(DateTime.parse('2009-08-11T19:28:18-04:00'), certificate.start_at)
          assert_equal(DateTime.parse('2009-08-20T00:59:16-04:00'), certificate.end_at)
          assert_equal('https://api-test.geocerts.com/1/orders/422815/certificate.xml', certificate.url)
          assert_equal("-----BEGIN CERTIFICATE-----\nMIIDATCCAmqgAwIBAgICHwkwDQYJKoZIhvcNAQEEBQAwSzELMAkGA1UEBhMCVVMx\nFTATBgNVBAoTDEdlb1RydXN0IEluYzElMCMGA1UEAxMcR2VvVHJ1c3QgUHJlLVBy\nb2R1Y3Rpb24gQ0EgMTAeFw0wOTA4MTEyMzI4MThaFw0wOTA4MjAwNDU5MTZaMIHI\nMQswCQYDVQQGEwJVUzEbMBkGA1UEChMSc3J2MDIud2F2ZXBhdGguY29tMRMwEQYD\nVQQLEwpHVDAzMTIzMjc1MTEwLwYDVQQLEyhTZWUgd3d3Lmdlb3RydXN0LmNvbS9y\nZXNvdXJjZXMvY3BzIChjKTA5MTcwNQYDVQQLEy5Eb21haW4gQ29udHJvbCBWYWxp\nZGF0ZWQgLSBRdWlja1NTTCBQcmVtaXVtKFIpMRswGQYDVQQDExJzcnYwMi53YXZl\ncGF0aC5jb20wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAOfnRzNL60aJdLL7\nSyJ7OFJPINg4yjLDLUJA7moeerN7QupUeJm68LHQ7juTRJ7lqkwTNK1hDRZuH7+6\nsM3ohFOjWv9D9hEWqR1tKAUBnhTJlTr8rYmvqbSNCWhUJZy53NqntiyDpg8kNOTM\nUVsY0cAn9e4vJHvh49t2AsMMAjtjAgMBAAGjdjB0MA4GA1UdDwEB/wQEAwIE8DBB\nBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vdGVzdC1jcmwuZ2VvdHJ1c3QuY29tL2Ny\nbHMvcHJlcHJvZGNhMS5jcmwwHwYDVR0jBBgwFoAUSu1cZmsN8sJTHAsEc92rVZad\nv4cwDQYJKoZIhvcNAQEEBQADgYEAJyNUrcKjcbtVatngWw6KCCtogp1V2eEt9BJM\nUVsY0cAn9e4vJHvh49t2AsMMAjtjAgMBAAGjdjB0MA4GA1UdDwEB/wQEAwIE8DBB\nBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vdGVzdC1jcmwuZ2VvdHJ1c3QuY29tL2Ny\ngrVniKk=\n-----END CERTIFICATE-----\n", certificate.certificate)
          assert_equal("-----BEGIN CERTIFICATE-----\nMIIDIDCCAomgAwIBAgIENd70zzANBgkqhkiG9w0BAQUFADBOMQswCQYDVQQGEwJV\nUzEQMA4GA1UEChMHRXF1aWZheDEtMCsGA1UECxMkRXF1aWZheCBTZWN1cmUgQ2Vy\ndGlmaWNhdGUgQXV0aG9yaXR5MB4XDTk4MDgyMjE2NDE1MVoXDTE4MDgyMjE2NDE1\nMVowTjELMAkGA1UEBhMCVVMxEDAOBgNVBAoTB0VxdWlmYXgxLTArBgNVBAsTJEVx\ndWlmYXggU2VjdXJlIENlcnRpZmljYXRlIEF1dGhvcml0eTCBnzANBgkqhkiG9w0B\nAQEFAAOBjQAwgYkCgYEAwV2xWGcIYu6gmi0fCG2RFGiYCh7+2gRvE4RiIcPRfM6f\nBeC4AfBONOziipUEZKzxa1NfBbPLZ4C/QgKO/t0BCezhABRP/PvwDN1Dulsr4R+A\ncJkVV5MW8Q+XarfCaCMczE1ZMKxRHjuvK9buY0V7xdlfUNLjUA86iOe/FP3gx7kC\nAwEAAaOCAQkwggEFMHAGA1UdHwRpMGcwZaBjoGGkXzBdMQswCQYDVQQGEwJVUzEQ\nMA4GA1UEChMHRXF1aWZheDEtMCsGA1UECxMkRXF1aWZheCBTZWN1cmUgQ2VydGlm\naWNhdGUgQXV0aG9yaXR5MQ0wCwYDVQQDEwRDUkwxMBoGA1UdEAQTMBGBDzIwMTgw\nODIyMTY0MTUxWjALBgNVHQ8EBAMCAQYwHwYDVR0jBBgwFoAUSOZo+SvSspXXR9gj\nIBBPM5iQn9QwHQYDVR0OBBYEFEjmaPkr0rKV10fYIyAQTzOYkJ/UMAwGA1UdEwQF\nMAMBAf8wGgYJKoZIhvZ9B0EABA0wCxsFVjMuMGMDAgbAMA0GCSqGSIb3DQEBBQUA\nMA4GA1UEChMHRXF1aWZheDEtMCsGA1UECxMkRXF1aWZheCBTZWN1cmUgQ2VydGlm\naWNhdGUgQXV0aG9yaXR5MQ0wCwYDVQQDEwRDUkwxMBoGA1UdEAQTMBGBDzIwMTgw\n1voqZiegDfqnc1zqcPGUIWVEX/r87yloqaKHee9570+sB3c4\n-----END CERTIFICATE-----", certificate.ca_root)
          assert !certificate.trial?
        end
      end
      
      should 'set the end at time' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/certificates.xml', :response => Responses::Certificate::All do
          assert_equal DateTime.parse('2009-09-08T12:57:10-04:00'), GeoCerts::Certificate.all.end_at
        end
      end
      
      should 'set the start at time' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/certificates.xml', :response => Responses::Certificate::All do
          assert_equal DateTime.parse('2009-08-09T12:57:10-04:00'), GeoCerts::Certificate.all.start_at
        end
      end
      
      should 'modify the queried window of time' do
        managed_server_request :get, 'https://api-test.geocerts.com/1/certificates.xml?start_at=2009-01-01T00:00:00+00:00&end_at=2009-01-02T00:00:00+00:00', :response => Responses::Certificate::All do
          GeoCerts::Certificate.all(:start_at => DateTime.parse('2009-01-01T00:00:00Z'), :end_at => DateTime.parse('2009-01-02T00:00:00Z'))
        end
      end
      
    end
    
    context 'find' do
      
      setup do
        managed_server_request :get, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::All do
          @order_id = GeoCerts::Order.all.first.id
        end
      end
      
      should 'return a GeoCerts::Certificate' do
        managed_server_request :get, "https://api-test.geocerts.com/1/orders/#{@order_id}/certificate.xml", :response => Responses::Certificate::Certificate do
          certificate = GeoCerts::Certificate.find(@order_id)
          assert_kind_of(GeoCerts::Certificate, certificate)
          assert_equal(@order_id, certificate.order_id)
        end
      end
      
      should 'properly populate the certificate data' do
        exclusively_mocked_request :get, 'https://api-test.geocerts.com/1/orders/422815/certificate.xml', :response => Responses::Certificate::Certificate do
          certificate = GeoCerts::Certificate.find(422815)
          assert_equal(422815,                certificate.order_id)
          assert_equal('93520',               certificate.geotrust_order_id)
          assert_equal('Renewed',             certificate.status)
          assert_equal('www.example.com',     certificate.common_name)
          assert_equal('1E08',                certificate.serial_number)
          assert_equal('Atlanta',             certificate.city)
          assert_equal('Georgia',             certificate.state)
          assert_equal('US',                  certificate.country)
          assert_equal('GeoCerts',            certificate.organization)
          assert_equal('Internet',            certificate.organizational_unit)
          assert_equal('ssladmin@example.com',certificate.approver_email)
          assert_equal('test@example.com',    certificate.reissue_email)
          assert_equal(DateTime.parse('2009-08-11T19:28:18-04:00'), certificate.start_at)
          assert_equal(DateTime.parse('2009-08-20T00:59:16-04:00'), certificate.end_at)
          assert_equal('https://api-test.geocerts.com/1/orders/422815/certificate.xml', certificate.url)
          assert_equal("-----BEGIN CERTIFICATE-----\nMIIDATCCAmqgAwIBAgICHwkwDQYJKoZIhvcNAQEEBQAwSzELMAkGA1UEBhMCVVMx\nFTATBgNVBAoTDEdlb1RydXN0IEluYzElMCMGA1UEAxMcR2VvVHJ1c3QgUHJlLVBy\nb2R1Y3Rpb24gQ0EgMTAeFw0wOTA4MTEyMzI4MThaFw0wOTA4MjAwNDU5MTZaMIHI\nMQswCQYDVQQGEwJVUzEbMBkGA1UEChMSc3J2MDIud2F2ZXBhdGguY29tMRMwEQYD\nVQQLEwpHVDAzMTIzMjc1MTEwLwYDVQQLEyhTZWUgd3d3Lmdlb3RydXN0LmNvbS9y\nZXNvdXJjZXMvY3BzIChjKTA5MTcwNQYDVQQLEy5Eb21haW4gQ29udHJvbCBWYWxp\nZGF0ZWQgLSBRdWlja1NTTCBQcmVtaXVtKFIpMRswGQYDVQQDExJzcnYwMi53YXZl\ncGF0aC5jb20wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAOfnRzNL60aJdLL7\nSyJ7OFJPINg4yjLDLUJA7moeerN7QupUeJm68LHQ7juTRJ7lqkwTNK1hDRZuH7+6\nsM3ohFOjWv9D9hEWqR1tKAUBnhTJlTr8rYmvqbSNCWhUJZy53NqntiyDpg8kNOTM\nUVsY0cAn9e4vJHvh49t2AsMMAjtjAgMBAAGjdjB0MA4GA1UdDwEB/wQEAwIE8DBB\nBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vdGVzdC1jcmwuZ2VvdHJ1c3QuY29tL2Ny\nbHMvcHJlcHJvZGNhMS5jcmwwHwYDVR0jBBgwFoAUSu1cZmsN8sJTHAsEc92rVZad\nv4cwDQYJKoZIhvcNAQEEBQADgYEAJyNUrcKjcbtVatngWw6KCCtogp1V2eEt9BJM\nUVsY0cAn9e4vJHvh49t2AsMMAjtjAgMBAAGjdjB0MA4GA1UdDwEB/wQEAwIE8DBB\nBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vdGVzdC1jcmwuZ2VvdHJ1c3QuY29tL2Ny\ngrVniKk=\n-----END CERTIFICATE-----\n", certificate.certificate)
          assert_equal("-----BEGIN CERTIFICATE-----\nMIIDIDCCAomgAwIBAgIENd70zzANBgkqhkiG9w0BAQUFADBOMQswCQYDVQQGEwJV\nUzEQMA4GA1UEChMHRXF1aWZheDEtMCsGA1UECxMkRXF1aWZheCBTZWN1cmUgQ2Vy\ndGlmaWNhdGUgQXV0aG9yaXR5MB4XDTk4MDgyMjE2NDE1MVoXDTE4MDgyMjE2NDE1\nMVowTjELMAkGA1UEBhMCVVMxEDAOBgNVBAoTB0VxdWlmYXgxLTArBgNVBAsTJEVx\ndWlmYXggU2VjdXJlIENlcnRpZmljYXRlIEF1dGhvcml0eTCBnzANBgkqhkiG9w0B\nAQEFAAOBjQAwgYkCgYEAwV2xWGcIYu6gmi0fCG2RFGiYCh7+2gRvE4RiIcPRfM6f\nBeC4AfBONOziipUEZKzxa1NfBbPLZ4C/QgKO/t0BCezhABRP/PvwDN1Dulsr4R+A\ncJkVV5MW8Q+XarfCaCMczE1ZMKxRHjuvK9buY0V7xdlfUNLjUA86iOe/FP3gx7kC\nAwEAAaOCAQkwggEFMHAGA1UdHwRpMGcwZaBjoGGkXzBdMQswCQYDVQQGEwJVUzEQ\nMA4GA1UEChMHRXF1aWZheDEtMCsGA1UECxMkRXF1aWZheCBTZWN1cmUgQ2VydGlm\naWNhdGUgQXV0aG9yaXR5MQ0wCwYDVQQDEwRDUkwxMBoGA1UdEAQTMBGBDzIwMTgw\nODIyMTY0MTUxWjALBgNVHQ8EBAMCAQYwHwYDVR0jBBgwFoAUSOZo+SvSspXXR9gj\nIBBPM5iQn9QwHQYDVR0OBBYEFEjmaPkr0rKV10fYIyAQTzOYkJ/UMAwGA1UdEwQF\nMAMBAf8wGgYJKoZIhvZ9B0EABA0wCxsFVjMuMGMDAgbAMA0GCSqGSIb3DQEBBQUA\nMA4GA1UEChMHRXF1aWZheDEtMCsGA1UECxMkRXF1aWZheCBTZWN1cmUgQ2VydGlm\naWNhdGUgQXV0aG9yaXR5MQ0wCwYDVQQDEwRDUkwxMBoGA1UdEAQTMBGBDzIwMTgw\n1voqZiegDfqnc1zqcPGUIWVEX/r87yloqaKHee9570+sB3c4\n-----END CERTIFICATE-----", certificate.ca_root)
          assert !certificate.trial?
        end
      end
      
      should 'raise a ResourceNotFound error' do
        managed_server_request :get, 'https://api-test.geocerts.com/1/orders/999999999/certificate.xml', :response => Responses::InvalidOrderId do
          assert_responds_with_exception(GeoCerts::ResourceNotFound, -90004) do
            GeoCerts::Certificate.find(999999999)
          end
        end
      end
      
    end
    
    context 'reissue' do
      
      setup do
        managed_server_request :get, 'https://api-test.geocerts.com/1/orders.xml', :response => Responses::Order::All do
          @order_id = GeoCerts::Order.all.first.id
        end
      end
      
      should 'return a GeoCerts::Certificate when successful' do
        managed_server_request :get, "https://api-test.geocerts.com/1/orders/#{@order_id}/certificate.xml", :response => Responses::Certificate::Certificate do
          managed_server_request :post, "https://api-test.geocerts.com/1/orders/422815/certificate.xml;reissue?order[csr][body]=testbody", :response => Responses::Certificate::Certificate do
            assert_kind_of(GeoCerts::Certificate, GeoCerts::Certificate.find(@order_id).reissue!(GeoCerts::CSR.new(:body => 'testbody')))
          end
        end
      end
      
      should 'raise an error with no CSR body provided' do
        managed_server_request :get, "https://api-test.geocerts.com/1/orders/#{@order_id}/certificate.xml", :response => Responses::Certificate::Certificate do
          managed_server_request :post, "https://api-test.geocerts.com/1/orders/#{@order_id}/certificate.xml;reissue?order[csr][body]=", :response => Responses::Certificate::MissingCSRBody do
            assert_responds_with_exception(GeoCerts::UnprocessableEntity, -90010) do
              GeoCerts::Certificate.find(@order_id).reissue!(GeoCerts::CSR.new(:body => nil))
            end
          end
        end
      end
      
    end
    
  end
  
end
