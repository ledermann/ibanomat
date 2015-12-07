require 'spec_helper'

describe Ibanomat do
  describe :find do
    subject {
      Ibanomat.find :bank_code => '37040044', :bank_account_number => '0532013000'
    }

    context 'Webservice is live' do
      context 'returns valid IBAN' do
        before :each do
          json_response = {
            'Institutsname'          => 'Commerzbank',
            'BIC'                    => 'COBADEFFXXX',
            'BLZ'                    => '37040044',
            'IBAN'                   => 'DE89370400440532013000',
            'KtoNr'                  => '0532013000',
            'RetCode'                => '00'
          }.to_json

          stub_request(:get, Ibanomat::URL).
            with(:query => {
              'b' => '37040044',
              'a' => '0532013000'
            }).
            to_return(:status => 200, :body => json_response)
        end

        it 'should return bank_name' do
          expect(subject[:bank_name]).to eq('Commerzbank')
        end

        it 'should return BIC' do
          expect(subject[:bic]).to eq('COBADEFFXXX')
        end

        it 'should return IBAN' do
          expect(subject[:iban]).to eq('DE89370400440532013000')
        end
      end

      context 'can not calculate IBAN' do
        before :each do
          json_response = {
            'BLZ'                    => '37040044',
            'KtoNr'                  => '0532013000',
            'RetCode'                => '10'
          }.to_json

          stub_request(:get, Ibanomat::URL).
            with(:query => {
              'b' => '37040044',
              'a' => '0532013000'
            }).
            to_return(:status => 200, :body => json_response)
        end

        it 'should return error code' do
          expect(subject[:return_code]).to eq('10')
        end
      end
    end

    context 'Webservice not found' do
      before :each do
        stub_request(:get, Ibanomat::URL).
          with(:query => {
            'b' => '37040044',
            'a' => '0532013000'
          }).
          to_return(:status => 404)
      end

      it 'should raise exception' do
        expect {
          subject
        }.to raise_error(RestClient::ResourceNotFound)
      end
    end

    context 'Webservice does not respond' do
      before :each do
        stub_request(:get, Ibanomat::URL).
          with(:query => {
            'b' => '37040044',
            'a' => '0532013000'
          }).
          to_timeout
      end

      it 'should raise exception' do
        expect {
          subject
        }.to raise_error(RestClient::RequestTimeout)
      end
    end
  end
end
