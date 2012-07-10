# GeoCerts

The GeoCerts library provides a Ruby interface to the GeoCerts REST API.  This API allows 
you to manage (lookup, create, and verify) your GeoCerts orders, events, certificates, and 
more.

## Installation

Add the following line to your application's Gemfile:

```ruby
gem 'geocerts'
```

And then execute:

```bash
$ bundle
```

Or, install it directly with:

```bash
$ gem install geocerts
```

## Usage

```ruby
require 'geocerts'

GeoCerts.partner_id = 'example'
GeoCerts.api_token  = 'abd123DEfg.....'

begin
  GeoCerts::Order.all                           # => [ GeoCerts::Order, GeoCerts::Order, ... ]
  GeoCerts::Order.find(12345).certificate       # => GeoCerts::Certificate
  GeoCerts::Product.all                         # => [ GeoCerts::Product, GeoCerts::Product, ... ]

  product = GeoCerts::Product.find('Q')
  product.user_agreement                        # => GeoCerts::Agreement
  puts product.user_agreement.text              # => "...."

  # Validate the requested order details
  validated_order = GeoCerts::Order.validate({
    :csr      => GeoCerts::CSR.new(:body => "-----BEGIN CERTIFICATE REQUEST-----\n...."),
    :product  => product
  })
  validated_order.renewal_information.indicator # => true
  validated_order.renewal_information.months    # => 1
  validated_order.csr.common_name               # => 'www.example.com'
  validated_order.csr.state                     # => 'Georgia'
  validated_order.total_price                   # => 99.00

  # Create a new Order
  order = GeoCerts::Order.new({
    :csr      => GeoCerts::CSR.new(:body => "-----BEGIN CERTIFICATE REQUEST-----\n...."),
    :product  => product,
    :years    => 3,
    :licenses => 1
  }).save

rescue GeoCerts::Exception
  puts $!.to_s
end
```

## Exceptions

Since this library does interface with an external system, there is a much greater risk of
exceptional situations.  As such, this library attempts to wrap all raised exceptions (due 
to authorization, connection, or other unforeseen issues) in the GeoCerts::Exception object.
All exceptions raised from within this library should inherit from this class.

Exceptions which are raised after successful connections, due to server or request issues, 
will be derived from GeoCerts::ExceptionWithResponse.  This object also inherits from 
GeoCerts::Exception, but contains the actual response details (including HTTP status code,
headers, and response body).

## Contributing
 
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

== Copyright

Copyright (c) 2009 {GeoCerts Inc.}[http://www.geocerts.com/]. See LICENSE for details.
