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
              'bank-code'           => '37040044',
              'bank-account-number' => '0532013000'
            }).
            to_return(:status => 200, :body => json_response)
        end

        it 'should return bank_name' do
          subject[:bank_name].should == 'Commerzbank'
        end

        it 'should return BIC' do
          subject[:bic].should == 'COBADEFFXXX'
        end

        it 'should return IBAN' do
          subject[:iban].should == 'DE89370400440532013000'
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
              'bank-code'           => '37040044',
              'bank-account-number' => '0532013000'
            }).
            to_return(:status => 200, :body => json_response)
        end

        it 'should return error' do
          subject.should == :error
        end
      end
    end

    context 'Webservice not found' do
      before :each do
        stub_request(:get, Ibanomat::URL).
          with(:query => {
            'bank-code'           => '37040044',
            'bank-account-number' => '0532013000'
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
            'bank-code'           => '37040044',
            'bank-account-number' => '0532013000'
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
