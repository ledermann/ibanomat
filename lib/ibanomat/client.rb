require 'net/http'
require 'json'

module Ibanomat
  class ResourceNotFoundError < RuntimeError
  end

  URL = 'https://www.sparkasse.de/bin/servlets/sparkasse/iban'

  def self.find(options)
    raise ArgumentError.new unless options.is_a?(Hash)
    if options[:bank_code].empty?
      raise ArgumentError.new('Option :bank_code is missing!')
    end
    if options[:bank_account_number].empty?
      raise ArgumentError.new('Option :bank_account_number is missing!')
    end

    uri = URI(URL)
    params = {
      'b' => options[:bank_code],
      'a' => options[:bank_account_number],
    }
    uri.query = URI.encode_www_form(params)

    case response = Net::HTTP.get_response(uri)
    when Net::HTTPSuccess
      hash = JSON.parse(response.body)

      {
        bank_name: hash['Institutsname'],
        bic: hash['BIC'],
        iban: hash['IBAN'],
        bank_code: hash['BLZ'],
        bank_account_number: hash['KtoNr'],
        return_code: hash['RetCode'],
      }
    when Net::HTTPNotFound
      raise ResourceNotFoundError
    else
      raise RuntimeError
    end
  end
end
