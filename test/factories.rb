Factory.define :order, :class => GeoCerts::Order do |o|
end

Factory.define :csr, :class => GeoCerts::CSR do |c|
  c.sequence(:body) { |n| "-----BEGIN CERTIFICATE REQUEST-----\r\nMIIBnDCCAQUCAQAwXDELMAkGA1UEBhMCVVMxEDAOBgNVBAgTB0Zsb3JpZGExEDAO\r\nBgNVBAcTB09ybGFuZG8xEzARBgNVBAoTClJhaWxzIEVudnkxFDASBgNVBAMTC3d3\r\ndy5mb28ubmV0MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDF0u2lgEznB8zF\r\nwtJjek80nx/XIVz777DFL4u39sXzX8uk4JXStZTMync2TMnWynzyQxc/BSCUNhuA\r\npck6dCQrzRgGki7XNYgAYbPk3Ey3DTyQDfackO5QX3ebRF/tzYvEAr+Gb1sNNcW+\r\n5IBfh+FhVQBI2IC53cjE47gqIG8joQIDAQABoAAwDQYJKoZIhvcNAQEFBQADgYEA\r\nqs+oWN3oXANAQAzy2l+gw0msSdpY2bFvTL6Y0JMCQRhV2Qf8g7Je00J0Hx1N30XK\r\nTsVZDd1Tt5xMYl9R/of2yvpp7SNgJG1u8GWDFR3sW+0H112Oi7L+ycePhte6+PU7\r\nm9zbh0f53SVbCaJKLThEMX1UgecO4waXL5VzznDjK0U#{n}=\r\n-----END CERTIFICATE REQUEST-----" }
  c.common_name     'geocerts.com'
  c.city            'Atlanta'
  c.state           'GA'
  c.country         'US'
  c.organization    'GeoCerts Inc'
end

Factory.define :product, :class => GeoCerts::Product do |p|
  p.sku             'Q'
end
