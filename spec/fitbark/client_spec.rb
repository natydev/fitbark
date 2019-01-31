require 'fitbark/client'
require 'fitbark/errors'
require 'fitbark/constants'

RSpec.describe Fitbark::Client do
  let!(:token) { SecureRandom.hex(30) }
  let(:subject) do
    described_class.new(token: token)
  end
  let(:headers_request) do
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{token}"
    }
  end
  context 'initialize' do
    it 'set variable @uri' do
      expect(subject.uri.to_s).to eq('https://app.fitbark.com/api/v2')
    end
  end
  context 'user' do
    context 'when response is success' do
      let!(:stub_webmock_success) do
        stub_request(:get, 'https://app.fitbark.com/api/v2/user')
          .with(headers: headers_request)
          .to_return(status: 200, body:
            ['{"user":{"slug":"1928b120-e865-4c45-97a4-20543821709c",',
             '"username":"foo@example.com","name":"John",',
             '"first_name":"Mirco","last_name":"Frison",',
             '"picture_hash":"40348cfbe02d81f02c99a74a3b0eafc4"}}']
             .join, headers: {})
      end
      it 'connect to endpoint user info' do
        expect(subject.user)
          .to have_requested(:get, 'https://app.fitbark.com/api/v2/user').once
      end
      it 'return a String' do
        expect(subject.user).to eq('')
      end
    end
  end
end
