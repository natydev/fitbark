require 'fitbark/auth'
require 'fitbark/constants'
require 'fitbark/errors'
require 'fitbark/data/shared.rb'
require 'fitbark/data/token'

RSpec.describe Fitbark::Auth do
  let!(:client_id) { SecureRandom.hex }
  let!(:client_secret) { Faker::Internet.password(8) }
  let!(:redirect_uri) { Faker::Internet.url('example.com') }
  let!(:redirect_uri_escaped) { CGI.escape(redirect_uri) }
  let!(:code) { SecureRandom.hex(20) }
  let!(:token) { SecureRandom.hex(30) }
  let!(:expires_in) { rand(3000..10_000) }

  context 'authorization_uri' do
    let(:subject) do
      described_class.new(client_id: client_id, redirect_uri: redirect_uri)
    end
    it 'render the authorization uri' do
      expect(subject.authorization_uri)
        .to eq(['https://app.fitbark.com/oauth/authorize?client_id=',
                "#{client_id}&redirect_uri=#{redirect_uri_escaped}",
                '&response_type=code'].join(''))
    end
  end
  context 'fetch_access_token!' do
    let!(:body_request) do
      { 'client_id' => client_id,
        'client_secret' => client_secret,
        'code' => code,
        'grant_type' => 'authorization_code',
        'redirect_uri' => redirect_uri }
    end
    context 'when response is success' do
      let!(:stub_webmock_success) do
        stub_request(:post, 'https://app.fitbark.com/oauth/token')
          .with(
            body: body_request
          )
          .to_return(status: 200, body:
            ["{\"access_token\":\"#{token}\",",
             "\"token_type\":\"bearer\",\"expires_in\":#{expires_in},",
             '"scope":"partners"}'].join, headers: {})
      end
      let(:subject) do
        described_class.new(client_id: client_id, client_secret: client_secret,
                            redirect_uri: redirect_uri, code: code)
      end
      it 'fetch the access token' do
        expect(subject.fetch_access_token!)
          .to have_requested(:post, 'https://app.fitbark.com/oauth/token').once
      end
      it 'returned response contains an object kind' \
      ' of Fitbark::Data::Token' do
        expect(subject.fetch_access_token!).to be_kind_of(Fitbark::Data::Token)
      end
      it 'set instance @token_data with an object kind' \
      ' of Fitbark::Data::Token' do
        subject.fetch_access_token!
        expect(subject.token_data).to be_kind_of(Fitbark::Data::Token)
      end
      it 'set instance @token with a string' \
      ' containing a token' do
        subject.fetch_access_token!
        expect(subject.token).to eq(token)
      end
    end
    context 'when response has error' do
      let!(:error_message) do
        ['The provided authorization grant is invalid, expired, revoked,',
         ' does not match the redirection URI used in the authorization ',
         'request, or was issued to another client.'].join
      end
      let!(:stub_webmock_error) do
        stub_request(:post, 'https://app.fitbark.com/oauth/token')
          .with(
            body: body_request
          )
          .to_return(status: 401, body:
            ['{"error":"invalid_grant",',
             "\"error_description\":\"#{error_message}\"}"].join,
                     headers: {})
      end
      let(:subject) do
        described_class.new(client_id: client_id, client_secret: client_secret,
                            redirect_uri: redirect_uri, code: code)
      end
      it 'raise a specific error' do
        expect { subject.fetch_access_token! }
          .to raise_error(
            Fitbark::Errors::FetchTokenError
          )
      end
    end
  end
  context 'fetch_token_info' do
    context 'when response is success' do
      let!(:stub_webmock_success) do
        stub_request(:get, 'https://app.fitbark.com/oauth/token/info')
          .with(
            headers: {
              'Content-Type' => 'application/json',
              'Authorization' => "Bearer #{token}"
            }
          )
          .to_return(status: 200, body:
            ['{"resource_owner_id":"365",',
             '"scopes":["public"],"expires_in_seconds":435765345,',
             '"application":{"uid":"35687765"}}'].join, headers: {})
      end
      let(:subject) do
        described_class.new(token: token)
      end
      it 'fetch the access token info' do
        expect(subject.fetch_token_info)
          .to have_requested(:get,
                             'https://app.fitbark.com/oauth/token/info').once
      end
      it 'returned response contains information data kind' \
      ' of Fitbark::Data::TokenInfo' do
        expect(subject.fetch_token_info)
          .to be_kind_of(Fitbark::Data::TokenInfo)
      end
      it 'set instance @token_data with an object kind' \
      ' of Fitbark::Data::TokenInfo' do
        subject.fetch_token_info
        expect(subject.token_info).to be_kind_of(Fitbark::Data::TokenInfo)
      end
    end
    context 'when response has error' do
      let!(:error_message) do
        ['The provided authorization grant is invalid, expired, revoked,',
         ' does not match the redirection URI used in the authorization ',
         'request, or was issued to another client.'].join
      end
      let!(:stub_webmock_error) do
        stub_request(:get, 'https://app.fitbark.com/oauth/token/info')
          .with(
            headers: {
              'Content-Type' => 'application/json',
              'Authorization' => "Bearer #{token}"
            }
          )
          .to_return(status: 401, body:
            ['{"error":"invalid_grant",',
             "\"error_description\":\"#{error_message}\"}"].join,
                     headers: {})
      end
      let(:subject) do
        described_class.new(token: token)
      end
      it 'raise a specific error' do
        expect { subject.fetch_token_info }
          .to raise_error(
            Fitbark::Errors::FetchTokenError
          )
      end
    end
  end
end
