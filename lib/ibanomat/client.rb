require 'rest-client'
require 'json'

module Ibanomat
  URL = 'https://www.sparkasse.de/bin/servlets/sparkasse/iban'

  def self.find(options)
    raise ArgumentError.new unless options.is_a?(Hash)
    raise ArgumentError.new('Option :bank_code is missing!') if options[:bank_code].empty?
    raise ArgumentError.new('Option :bank_account_number is missing!') if options[:bank_account_number].empty?

    response = RestClient.get URL, {
                                :params => {
                                  'b' => options[:bank_code],
                                  'a' => options[:bank_account_number]
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
