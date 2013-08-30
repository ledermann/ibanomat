# IBANomat

The gem is a wrapper for a [web service of the german "Sparkasse"](http://www.sparkasse.de/firmenkunden/konto-karte/iban-rechner.html). It calculates the **IBAN** for a given Bankleitzahl (BLZ) and bank account number. Behind the scenes the web service returns JSON ([Example here](http://www.sparkasse.de/firmenkunden/konto-karte/iban-resources/iban/iban.php?bank-code=37040044&bank-account-number=0532013000))

**WARNING: I'm not affiliated in any way with the web service or the Sparkasse. The web service seems not to be official. Maybe it will be offline soon. I don't find any terms of use on their website. Use this gem at your own risk!**


## Installation

Add this line to your application's Gemfile:

    gem 'ibanomat'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ibanomat


## Usage

```ruby
  Ibanomat.find :bank_code => '37040044', :bank_account_number => '0532013000'

  # =>
  # {
  #     :bank_name => 'Commerzbank',
  #     :bic       => 'COBADEFFXXX',
  #     :iban      => 'DE89370400440532013000',
  #     :code      => '00'
  # }
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
