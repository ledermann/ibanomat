# IBANomat

[![Build Status](https://secure.travis-ci.org/ledermann/ibanomat.svg)](http://travis-ci.org/ledermann/ibanomat)
[![Code Climate](https://codeclimate.com/github/ledermann/ibanomat.svg)](https://codeclimate.com/github/ledermann/ibanomat)
[![Gem Version](https://badge.fury.io/rb/ibanomat.svg)](http://badge.fury.io/rb/ibanomat)
[![Dependency Status](https://gemnasium.com/ledermann/ibanomat.svg)](https://gemnasium.com/ledermann/ibanomat)

The gem is a Ruby wrapper for a [web service of the german "Sparkasse"](https://www.sparkasse.de/unsere-loesungen/privatkunden/rund-ums-konto/iban-rechner.html). It calculates the **IBAN** for a given bank code (in German "Bankleitzahl") and bank account number ("Kontonummer"). Behind the scenes the web service returns JSON ([Example here](https://www.sparkasse.de/bin/servlets/sparkasse/iban?a=0532013000&b=37040044))


**WARNING: I'm not affiliated in any way with the web service or the Sparkasse. The web service seems not to be official. Maybe it will be offline soon. I didn't find any terms of use on their website. Use this gem at your own risk!**

## Requirements

Ruby 2.0.0 or newer.


## Installation

Add this line to your application's Gemfile:

    gem 'ibanomat'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ibanomat


## Usage

```ruby
  Ibanomat.find :bank_code => '37040044', :bank_account_number => '532013000'
  # =>
  # {
  #             :bank_name => 'Commerzbank',
  #                   :bic => 'COBADEFFXXX',
  #                  :iban => 'DE89370400440532013000',
  #             :bank_code => '37040044',
  #   :bank_account_number => '0532013000',
  #           :return_code => '00'
  # }
```

A `return_code` other than '00' indicates a warning or error.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


# Author

Copyright (c) 2013-2019 Georg Ledermann, released under the MIT license
