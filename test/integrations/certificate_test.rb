require 'test_helper'

class GeoCerts::CertificateTest < Test::Unit::TestCase

  context 'Certificate (using the API)' do

    context 'all' do
      subject do
        @_subject ||= VCR.use_cassette('certificates') do
          GeoCerts::Certificate.all
        end
      end

      should 'return a collection of GeoCerts::Certificates' do
        assert subject.all? { |item| item.kind_of?(GeoCerts::Certificate) }
      end

      should 'return a certificate' do
        assert_equal 1, subject.size
      end

      should 'properly populate the certificate data' do
        certificate = subject.first
        assert_equal('R6FQJ89F', certificate.order_id)
        assert_equal('173141', certificate.geotrust_order_id)
        assert_equal('Active', certificate.status)
        assert_equal('envylabs.com', certificate.common_name)
        assert_equal('5A43', certificate.serial_number)
        assert_equal('', certificate.city)
        assert_equal('', certificate.state)
        assert_equal('US', certificate.country)
        assert_equal('envylabs.com', certificate.organization)
        assert_equal('Domain Control Validated - GeoTrust(R) SSL Trial', certificate.organizational_unit)
        assert_equal(DateTime.parse('2011-01-11T07:06:37+00:00'), certificate.start_at)
        assert_equal(DateTime.parse('2011-01-20T15:23:06+00:00'), certificate.end_at)
        assert_match(%r{/orders/432866/certificate\.xml$}, certificate.url)
        assert_equal(<<-_certificate_, certificate.certificate)
-----BEGIN CERTIFICATE-----
MIIEYDCCA0igAwIBAgICWkMwDQYJKoZIhvcNAQEFBQAwTzELMAkGA1UEBhMCVVMx
FTATBgNVBAoTDEdlb1RydXN0IEluYzEpMCcGA1UEAxMgR2VvVHJ1c3QgUHJlLVBy
b2R1Y3Rpb24gU1VCIENBIDMwHhcNMTEwMTExMDcwNjM3WhcNMTEwMTIwMTUyMzA2
WjCBtDELMAkGA1UEBhMCVVMxFTATBgNVBAoTDGVudnlsYWJzLmNvbTETMBEGA1UE
CxMKR1Q4Nzg5NDQwNDEnMCUGA1UECxMed3d3Lmdlb3RydXN0LmNvbS9yZXNvdXJj
ZXMvY3BzMTkwNwYDVQQLEzBEb21haW4gQ29udHJvbCBWYWxpZGF0ZWQgLSBHZW9U
cnVzdChSKSBTU0wgVHJpYWwxFTATBgNVBAMTDGVudnlsYWJzLmNvbTCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBALlhCULQ4sdyrB48Fz7+FZ8c7IYJAXpJ
U/bnsTeRvf2je5xD9ZOpQbLAlprXaDWWd28LJOenQ7zxPGNGhcsdSnZ/zZautNVh
9hgTmqfOCqZO6UV3atmrR3Wc69ZRbIEKf6IjwWpA1IjIa4fI82UVXL2k0R2ZZyz1
gvBapa50WEWqYvzv385q9NAPlqqZsrh11Sl1jxdk5+a9y74TOyFRwPHH2ZVVAYur
Z0JuiAbyiKD+XruL9A2eXw1cdAuUiOsmoXrt9lYyXhwcgrrgpdt/uP4+fn5HR+QO
EPrB6lX48O3r06KkoYNJ3PKw+UhhJpiBK8hn7IR5nHKSb0fq+6Rd+08CAwEAAaOB
3zCB3DAfBgNVHSMEGDAWgBRlda4iaOfdlCsTaNUsGCuGGFWgxTAOBgNVHQ8BAf8E
BAMCBaAwFwYDVR0RBBAwDoIMZW52eWxhYnMuY29tMEQGA1UdHwQ9MDswOaA3oDWG
M2h0dHA6Ly90ZXN0LWNybC5nZW90cnVzdC5jb20vY3Jscy9wcmVwcm9kc3ViY2Ez
LmNybDAMBgNVHRMBAf8EAjAAMB0GA1UdDgQWBBSUvveqOz3h0R8PCrqDKFz3y1Ek
kjAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwDQYJKoZIhvcNAQEFBQAD
ggEBAIlYkCdEmbs6F9OR3KEH2LKJ6QMC3+0+xVLF+Hy03iyLHfn0c9S+lC4Ox8Wz
trRAwyWZ7yPJAirF4/TiGyFlqATZ7Fm63+bouNpLyYDdmlznvfamE7vCFy3rTPWr
lTJLU10SrSpb0LgEAvI6a7HX31risInjPRDNTC25yn7D4rOkpQN1iE2BRPjkia2r
FHf5SVMRgY8yYBTik2cjnxCYrG1EmbcpqM6J+QjMZiRMIO/EWLnP78Tj8uAejgzd
oUXXRSwjOul7ZWfb9sTydjrUAz8WBfFVuo3/g3B95GEjWxatzaNQTriM7MrZSshq
5njFPdPu2+JKXyZnyjUEu7RdLNA=
-----END CERTIFICATE-----
_certificate_

        assert_equal(<<-_certificate_, certificate.ca_root)
-----BEGIN CERTIFICATE-----
MIIDVDCCAjygAwIBAgIDAjRWMA0GCSqGSIb3DQEBBQUAMEIxCzAJBgNVBAYTAlVT
MRYwFAYDVQQKEw1HZW9UcnVzdCBJbmMuMRswGQYDVQQDExJHZW9UcnVzdCBHbG9i
YWwgQ0EwHhcNMDIwNTIxMDQwMDAwWhcNMjIwNTIxMDQwMDAwWjBCMQswCQYDVQQG
EwJVUzEWMBQGA1UEChMNR2VvVHJ1c3QgSW5jLjEbMBkGA1UEAxMSR2VvVHJ1c3Qg
R2xvYmFsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2swYYzD9
9BcjGlZ+W988bDjkcbd4kdS8odhM+KhDtgPpTSEHCIjaWC9mOSm9BXiLnTjoBbdq
fnGk5sRgprDvgOSJKA+eJdbtg/OtppHHmMlCGDUUna2YRpIuT8rxh0PBFpVXLVDv
iS2Aelet8u5fa9IAjbkU+BQVNdnARqN7csiRv8lVK83Qlz6cJmTM386DGXHKTubU
1XupGc1V3sjs0l44U+VcT4wt/lAjNvxm5suOpDkZALeVAjmRCw7+OC7RHQWa9k0+
bw8HHa8sHo9gOeL6NlMTOdReJivbPagUvTLrGAMoUgRx5aszPeE4uwc2hGKceeoW
MPRfwCvocWvk+QIDAQABo1MwUTAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBTA
ephojYn7qwVkDBF9qn1luMrMTjAfBgNVHSMEGDAWgBTAephojYn7qwVkDBF9qn1l
uMrMTjANBgkqhkiG9w0BAQUFAAOCAQEANeMpauUvXVSOKVCUn5kaFOSPeCpilKIn
Z57QzxpeR+nBsqTP3UEaBU6bS+5Kb1VSsyShNwrrZHYqLizz/Tt1kL/6cdjHPTfS
tQWVYrmm3ok9Nns4d0iXrKYgjy6myQzCsplFAMfOEVEiIuCl6rYVSAlk6l5PdPcF
PseKUgzbFbS9bZvlxrFUaKnjaZC2mqUPuLk/IH2uSrW4nOQdtqvmlKXBx4Ot2/Un
hw4EbNX/3aBd7YdStysVAq45pmp06drE57xNNB6pXE0zX5IJL4hmXXeXxx12E6nV
5fEWCRE11azbJHFwLJhWC9kXtNHjUStedejV0NxPNO3CBWaAocvmMw==
-----END CERTIFICATE-----
_certificate_

        assert_equal([<<-_certificate_], certificate.ca_intermediates)
-----BEGIN CERTIFICATE-----
MIID+jCCAuKgAwIBAgIDAjbSMA0GCSqGSIb3DQEBBQUAMEIxCzAJBgNVBAYTAlVT
MRYwFAYDVQQKEw1HZW9UcnVzdCBJbmMuMRswGQYDVQQDExJHZW9UcnVzdCBHbG9i
YWwgQ0EwHhcNMTAwMjI2MjEzMjMxWhcNMjAwMjI1MjEzMjMxWjBhMQswCQYDVQQG
EwJVUzEWMBQGA1UEChMNR2VvVHJ1c3QgSW5jLjEdMBsGA1UECxMURG9tYWluIFZh
bGlkYXRlZCBTU0wxGzAZBgNVBAMTEkdlb1RydXN0IERWIFNTTCBDQTCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAKa7jnrNpJxiV9RRMEJ7ixqy0ogGrTs8
KRMMMbxp+Z9alNoGuqwkBJ7O1KrESGAA+DSuoZOv3gR+zfhcIlINVlPrqZTP+3RE
60OUpJd6QFc1tqRi2tVI+Hrx7JC1Xzn+Y3JwyBKF0KUuhhNAbOtsTdJU/V8+Jh9m
cajAuIWe9fV1j9qRTonjynh0MF8VCpmnyoM6djVI0NyLGiJOhaRO+kltK3C+jgwh
w2LMpNGtFmuae8tk/426QsMmqhV4aJzs9mvIDFcN5TgH02pXA50gDkvEe4GwKhz1
SupKmEn+Als9AxSQKH6a9HjQMYRX5Uw4ekIR4vUoUQNLIBW7Ihq28BUCAwEAAaOB
2TCB1jAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYEFIz02ZMKR7wAoErOS3VuoLaw
sn78MB8GA1UdIwQYMBaAFMB6mGiNifurBWQMEX2qfWW4ysxOMBIGA1UdEwEB/wQI
MAYBAf8CAQAwOgYDVR0fBDMwMTAvoC2gK4YpaHR0cDovL2NybC5nZW90cnVzdC5j
b20vY3Jscy9ndGdsb2JhbC5jcmwwNAYIKwYBBQUHAQEEKDAmMCQGCCsGAQUFBzAB
hhhodHRwOi8vb2NzcC5nZW90cnVzdC5jb20wDQYJKoZIhvcNAQEFBQADggEBADOR
NxHbQPnejLICiHevYyHBrbAN+qB4VqOC/btJXxRtyNxflNoRZnwekcW22G1PqvK/
ISh+UqKSeAhhaSH+LeyCGIT0043FiruKzF3mo7bMbq1vsw5h7onOEzRPSVX1ObuZ
lvD16lo8nBa9AlPwKg5BbuvvnvdwNs2AKnbIh+PrI7OWLOYdlF8cpOLNJDErBjgy
YWE5XIlMSB1CyWee0r9Y9/k3MbBn3Y0mNhp4GgkZPJMHcCrhfCn13mZXCxJeFu1e
vTezMGnGkqX2Gdgd+DYSuUuVlZzQzmwwpxb79k1ktl8qFJymyFWOIPllByTMOAVM
IIi0tWeUz12OYjf+xLQ=
-----END CERTIFICATE-----
_certificate_

        assert certificate.trial?
      end

      should 'set the end at time' do
        assert_equal DateTime.parse('2011-01-12T19:53:05+00:00'),
          subject.end_at
      end

      should 'set the start at time' do
        assert_equal DateTime.parse('2010-12-12T19:53:05+00:00'),
          subject.start_at
      end

      should_eventually 'modify the queried window of time' do
        VCR.use_cassette('certificates_query_window') do
          result = GeoCerts::Certificate.all({
            :start_at => DateTime.parse('2009-01-01T00:00:00Z'),
            :end_at => DateTime.parse('2009-01-02T00:00:00Z')
          })
          assert_equal DateTime.parse('2009-01-01T00:00:00Z'),
            subject.start_at.to_s
          assert_equal  DateTime.parse('2009-01-02T00:00:00Z'),
            subject.end_at.to_s
        end
      end

    end

    context 'find' do

      setup do
        managed_server_request :get, '/orders.xml', :response => Responses::Order::All do
          @order_id = GeoCerts::Order.all.first.id
        end
      end

      should 'return a GeoCerts::Certificate' do
        managed_server_request :get, "/orders/#{@order_id}/certificate.xml", :response => Responses::Certificate::Certificate do
          certificate = GeoCerts::Certificate.find(@order_id)
          assert_kind_of(GeoCerts::Certificate, certificate)
          assert_equal(@order_id, certificate.order_id)
        end
      end

      should 'properly populate the certificate data' do
        exclusively_mocked_request :get, '/orders/422815/certificate.xml', :response => Responses::Certificate::Certificate do
          certificate = GeoCerts::Certificate.find(422815)
          assert_equal('422815',              certificate.order_id)
          assert_equal('93520',               certificate.geotrust_order_id)
          assert_equal('Renewed',             certificate.status)
          assert_equal('www.example.com',     certificate.common_name)
          assert_equal('1E08',                certificate.serial_number)
          assert_equal('Atlanta',             certificate.city)
          assert_equal('Georgia',             certificate.state)
          assert_equal('US',                  certificate.country)
          assert_equal('GeoCerts',            certificate.organization)
          assert_equal('Internet',            certificate.organizational_unit)
          assert_equal(DateTime.parse('2009-08-11T19:28:18-04:00'), certificate.start_at)
          assert_equal(DateTime.parse('2009-08-20T00:59:16-04:00'), certificate.end_at)
          assert_match(%r{/orders/422815/certificate\.xml$}, certificate.url)
          assert_equal("-----BEGIN CERTIFICATE-----\nMIIDATCCAmqgAwIBAgICHwkwDQYJKoZIhvcNAQEEBQAwSzELMAkGA1UEBhMCVVMx\nFTATBgNVBAoTDEdlb1RydXN0IEluYzElMCMGA1UEAxMcR2VvVHJ1c3QgUHJlLVBy\nb2R1Y3Rpb24gQ0EgMTAeFw0wOTA4MTEyMzI4MThaFw0wOTA4MjAwNDU5MTZaMIHI\nMQswCQYDVQQGEwJVUzEbMBkGA1UEChMSc3J2MDIud2F2ZXBhdGguY29tMRMwEQYD\nVQQLEwpHVDAzMTIzMjc1MTEwLwYDVQQLEyhTZWUgd3d3Lmdlb3RydXN0LmNvbS9y\nZXNvdXJjZXMvY3BzIChjKTA5MTcwNQYDVQQLEy5Eb21haW4gQ29udHJvbCBWYWxp\nZGF0ZWQgLSBRdWlja1NTTCBQcmVtaXVtKFIpMRswGQYDVQQDExJzcnYwMi53YXZl\ncGF0aC5jb20wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAOfnRzNL60aJdLL7\nSyJ7OFJPINg4yjLDLUJA7moeerN7QupUeJm68LHQ7juTRJ7lqkwTNK1hDRZuH7+6\nsM3ohFOjWv9D9hEWqR1tKAUBnhTJlTr8rYmvqbSNCWhUJZy53NqntiyDpg8kNOTM\nUVsY0cAn9e4vJHvh49t2AsMMAjtjAgMBAAGjdjB0MA4GA1UdDwEB/wQEAwIE8DBB\nBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vdGVzdC1jcmwuZ2VvdHJ1c3QuY29tL2Ny\nbHMvcHJlcHJvZGNhMS5jcmwwHwYDVR0jBBgwFoAUSu1cZmsN8sJTHAsEc92rVZad\nv4cwDQYJKoZIhvcNAQEEBQADgYEAJyNUrcKjcbtVatngWw6KCCtogp1V2eEt9BJM\nUVsY0cAn9e4vJHvh49t2AsMMAjtjAgMBAAGjdjB0MA4GA1UdDwEB/wQEAwIE8DBB\nBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vdGVzdC1jcmwuZ2VvdHJ1c3QuY29tL2Ny\ngrVniKk=\n-----END CERTIFICATE-----\n", certificate.certificate)
          assert_equal("-----BEGIN CERTIFICATE-----\nMIIDIDCCAomgAwIBAgIENd70zzANBgkqhkiG9w0BAQUFADBOMQswCQYDVQQGEwJV\nUzEQMA4GA1UEChMHRXF1aWZheDEtMCsGA1UECxMkRXF1aWZheCBTZWN1cmUgQ2Vy\ndGlmaWNhdGUgQXV0aG9yaXR5MB4XDTk4MDgyMjE2NDE1MVoXDTE4MDgyMjE2NDE1\nMVowTjELMAkGA1UEBhMCVVMxEDAOBgNVBAoTB0VxdWlmYXgxLTArBgNVBAsTJEVx\ndWlmYXggU2VjdXJlIENlcnRpZmljYXRlIEF1dGhvcml0eTCBnzANBgkqhkiG9w0B\nAQEFAAOBjQAwgYkCgYEAwV2xWGcIYu6gmi0fCG2RFGiYCh7+2gRvE4RiIcPRfM6f\nBeC4AfBONOziipUEZKzxa1NfBbPLZ4C/QgKO/t0BCezhABRP/PvwDN1Dulsr4R+A\ncJkVV5MW8Q+XarfCaCMczE1ZMKxRHjuvK9buY0V7xdlfUNLjUA86iOe/FP3gx7kC\nAwEAAaOCAQkwggEFMHAGA1UdHwRpMGcwZaBjoGGkXzBdMQswCQYDVQQGEwJVUzEQ\nMA4GA1UEChMHRXF1aWZheDEtMCsGA1UECxMkRXF1aWZheCBTZWN1cmUgQ2VydGlm\naWNhdGUgQXV0aG9yaXR5MQ0wCwYDVQQDEwRDUkwxMBoGA1UdEAQTMBGBDzIwMTgw\nODIyMTY0MTUxWjALBgNVHQ8EBAMCAQYwHwYDVR0jBBgwFoAUSOZo+SvSspXXR9gj\nIBBPM5iQn9QwHQYDVR0OBBYEFEjmaPkr0rKV10fYIyAQTzOYkJ/UMAwGA1UdEwQF\nMAMBAf8wGgYJKoZIhvZ9B0EABA0wCxsFVjMuMGMDAgbAMA0GCSqGSIb3DQEBBQUA\nMA4GA1UEChMHRXF1aWZheDEtMCsGA1UECxMkRXF1aWZheCBTZWN1cmUgQ2VydGlm\naWNhdGUgQXV0aG9yaXR5MQ0wCwYDVQQDEwRDUkwxMBoGA1UdEAQTMBGBDzIwMTgw\n1voqZiegDfqnc1zqcPGUIWVEX/r87yloqaKHee9570+sB3c4\n-----END CERTIFICATE-----", certificate.ca_root)
          assert !certificate.trial?
        end
      end

      should 'raise a ResourceNotFound error' do
        managed_server_request :get, '/orders/999999999/certificate.xml', :response => Responses::InvalidOrderId do
          assert_responds_with_exception(GeoCerts::ResourceNotFound, -90004) do
            GeoCerts::Certificate.find(999999999)
          end
        end
      end

    end

    context 'find_by_order_id' do

      setup do
        managed_server_request :get, '/orders.xml', :response => Responses::Order::All do
          @order_id = GeoCerts::Order.all.first.id
        end
      end

      should 'return a GeoCerts::Certificate' do
        managed_server_request :get, "/orders/#{@order_id}/certificate.xml", :response => Responses::Certificate::Certificate do
          certificate = GeoCerts::Certificate.find_by_order_id(@order_id)
          assert_kind_of(GeoCerts::Certificate, certificate)
          assert_equal(@order_id, certificate.order_id)
        end
      end

      should 'properly populate the certificate data' do
        exclusively_mocked_request :get, '/orders/422815/certificate.xml', :response => Responses::Certificate::Certificate do
          certificate = GeoCerts::Certificate.find_by_order_id(422815)
          assert_equal('422815',              certificate.order_id)
          assert_equal('93520',               certificate.geotrust_order_id)
          assert_equal('Renewed',             certificate.status)
          assert_equal('www.example.com',     certificate.common_name)
          assert_equal('1E08',                certificate.serial_number)
          assert_equal('Atlanta',             certificate.city)
          assert_equal('Georgia',             certificate.state)
          assert_equal('US',                  certificate.country)
          assert_equal('GeoCerts',            certificate.organization)
          assert_equal('Internet',            certificate.organizational_unit)
          assert_equal(DateTime.parse('2009-08-11T19:28:18-04:00'), certificate.start_at)
          assert_equal(DateTime.parse('2009-08-20T00:59:16-04:00'), certificate.end_at)
          assert_match(%r{/orders/422815/certificate\.xml$}, certificate.url)
          assert_equal("-----BEGIN CERTIFICATE-----\nMIIDATCCAmqgAwIBAgICHwkwDQYJKoZIhvcNAQEEBQAwSzELMAkGA1UEBhMCVVMx\nFTATBgNVBAoTDEdlb1RydXN0IEluYzElMCMGA1UEAxMcR2VvVHJ1c3QgUHJlLVBy\nb2R1Y3Rpb24gQ0EgMTAeFw0wOTA4MTEyMzI4MThaFw0wOTA4MjAwNDU5MTZaMIHI\nMQswCQYDVQQGEwJVUzEbMBkGA1UEChMSc3J2MDIud2F2ZXBhdGguY29tMRMwEQYD\nVQQLEwpHVDAzMTIzMjc1MTEwLwYDVQQLEyhTZWUgd3d3Lmdlb3RydXN0LmNvbS9y\nZXNvdXJjZXMvY3BzIChjKTA5MTcwNQYDVQQLEy5Eb21haW4gQ29udHJvbCBWYWxp\nZGF0ZWQgLSBRdWlja1NTTCBQcmVtaXVtKFIpMRswGQYDVQQDExJzcnYwMi53YXZl\ncGF0aC5jb20wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAOfnRzNL60aJdLL7\nSyJ7OFJPINg4yjLDLUJA7moeerN7QupUeJm68LHQ7juTRJ7lqkwTNK1hDRZuH7+6\nsM3ohFOjWv9D9hEWqR1tKAUBnhTJlTr8rYmvqbSNCWhUJZy53NqntiyDpg8kNOTM\nUVsY0cAn9e4vJHvh49t2AsMMAjtjAgMBAAGjdjB0MA4GA1UdDwEB/wQEAwIE8DBB\nBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vdGVzdC1jcmwuZ2VvdHJ1c3QuY29tL2Ny\nbHMvcHJlcHJvZGNhMS5jcmwwHwYDVR0jBBgwFoAUSu1cZmsN8sJTHAsEc92rVZad\nv4cwDQYJKoZIhvcNAQEEBQADgYEAJyNUrcKjcbtVatngWw6KCCtogp1V2eEt9BJM\nUVsY0cAn9e4vJHvh49t2AsMMAjtjAgMBAAGjdjB0MA4GA1UdDwEB/wQEAwIE8DBB\nBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vdGVzdC1jcmwuZ2VvdHJ1c3QuY29tL2Ny\ngrVniKk=\n-----END CERTIFICATE-----\n", certificate.certificate)
          assert_equal("-----BEGIN CERTIFICATE-----\nMIIDIDCCAomgAwIBAgIENd70zzANBgkqhkiG9w0BAQUFADBOMQswCQYDVQQGEwJV\nUzEQMA4GA1UEChMHRXF1aWZheDEtMCsGA1UECxMkRXF1aWZheCBTZWN1cmUgQ2Vy\ndGlmaWNhdGUgQXV0aG9yaXR5MB4XDTk4MDgyMjE2NDE1MVoXDTE4MDgyMjE2NDE1\nMVowTjELMAkGA1UEBhMCVVMxEDAOBgNVBAoTB0VxdWlmYXgxLTArBgNVBAsTJEVx\ndWlmYXggU2VjdXJlIENlcnRpZmljYXRlIEF1dGhvcml0eTCBnzANBgkqhkiG9w0B\nAQEFAAOBjQAwgYkCgYEAwV2xWGcIYu6gmi0fCG2RFGiYCh7+2gRvE4RiIcPRfM6f\nBeC4AfBONOziipUEZKzxa1NfBbPLZ4C/QgKO/t0BCezhABRP/PvwDN1Dulsr4R+A\ncJkVV5MW8Q+XarfCaCMczE1ZMKxRHjuvK9buY0V7xdlfUNLjUA86iOe/FP3gx7kC\nAwEAAaOCAQkwggEFMHAGA1UdHwRpMGcwZaBjoGGkXzBdMQswCQYDVQQGEwJVUzEQ\nMA4GA1UEChMHRXF1aWZheDEtMCsGA1UECxMkRXF1aWZheCBTZWN1cmUgQ2VydGlm\naWNhdGUgQXV0aG9yaXR5MQ0wCwYDVQQDEwRDUkwxMBoGA1UdEAQTMBGBDzIwMTgw\nODIyMTY0MTUxWjALBgNVHQ8EBAMCAQYwHwYDVR0jBBgwFoAUSOZo+SvSspXXR9gj\nIBBPM5iQn9QwHQYDVR0OBBYEFEjmaPkr0rKV10fYIyAQTzOYkJ/UMAwGA1UdEwQF\nMAMBAf8wGgYJKoZIhvZ9B0EABA0wCxsFVjMuMGMDAgbAMA0GCSqGSIb3DQEBBQUA\nMA4GA1UEChMHRXF1aWZheDEtMCsGA1UECxMkRXF1aWZheCBTZWN1cmUgQ2VydGlm\naWNhdGUgQXV0aG9yaXR5MQ0wCwYDVQQDEwRDUkwxMBoGA1UdEAQTMBGBDzIwMTgw\n1voqZiegDfqnc1zqcPGUIWVEX/r87yloqaKHee9570+sB3c4\n-----END CERTIFICATE-----", certificate.ca_root)
          assert !certificate.trial?
        end
      end

      should 'not raise a ResourceNotFound error, instead returning nil' do
        managed_server_request :get, '/orders/999999999/certificate.xml', :response => Responses::InvalidOrderId do
          assert_responds_without_exception(GeoCerts::ResourceNotFound, -90004) do
            assert_nil GeoCerts::Certificate.find_by_order_id(999999999)
          end
        end
      end

    end

    context 'reissue' do

      setup do
        managed_server_request :get, '/orders.xml', :response => Responses::Order::All do
          @order_id = GeoCerts::Order.all.first.id
        end
      end

      should 'return a GeoCerts::Certificate when successful' do
        managed_server_request :get, "/orders/#{@order_id}/certificate.xml", :response => Responses::Certificate::Certificate do
          managed_server_request :post, "/orders/422815/certificate/reissue.xml?certificate[csr][body]=testbody", :response => Responses::Certificate::Certificate do
            assert_kind_of(GeoCerts::Certificate, GeoCerts::Certificate.find(@order_id).reissue!(GeoCerts::CSR.new(:body => 'testbody')))
          end
        end
      end

      should 'raise an error with no CSR body provided' do
        managed_server_request :get, "/orders/#{@order_id}/certificate.xml", :response => Responses::Certificate::Certificate do
          managed_server_request :post, "/orders/#{@order_id}/certificate/reissue.xml?certificate[csr][body]=", :response => Responses::Certificate::MissingCSRBody do
            assert_responds_with_exception(GeoCerts::UnprocessableEntity, -90010) do
              GeoCerts::Certificate.find(@order_id).reissue!(GeoCerts::CSR.new(:body => nil))
            end
          end
        end
      end

    end

  end

end
