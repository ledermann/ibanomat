require 'rest-client'
require 'json'

module Ibanomat
  URL = 'http://www.sparkasse.de/firmenkunden/konto-karte/iban-resources/iban/iban.php'

  def self.find(options)
    raise ArgumentError.new unless options.is_a?(Hash)
    raise ArgumentError.new('Option :bank_code is missing!') if options[:bank_code].empty?

    response = RestClient.get URL, {
                                :params => {
                                  'bank-code'           => options[:bank_code],
                                  'bank-account-number' => options[:bank_account_number]
                                },
                                :accept => :json
                              }
    if response.code == 200
      hash = JSON.parse(response)

      { :bank_name           => hash['Institutsname'],
        :bic                 => hash['BIC'],
        :iban                => hash['IBAN'],
        :bank_code           => hash['BLZ'],
        :bank_account_number => hash['KtoNr'],
        :return_code         => hash['RetCode']
      }
    end
  end
end
