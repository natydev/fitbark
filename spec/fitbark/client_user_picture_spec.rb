require 'fitbark/client'
require 'fitbark/errors'
require 'fitbark/constants'
require 'fitbark/handler/v2/base.rb'
require 'fitbark/handler/v2/user_picture.rb'
require 'fitbark/data/user_picture.rb'

RSpec.describe Fitbark::Client do
  let!(:token) { random_token }
  let!(:user_picture_response) { json_response(:user_picture) }
  let(:subject) do
    described_class.new(token: token)
  end

  context 'user_picture' do
    context 'when response is success' do
      let!(:stub_webmock_success) do
        stub_request(:get, "#{api_uri_request}/picture/user/abc")
          .with(headers: api_headers_request(token))
          .to_return(status: 200, body:
            user_picture_response, headers: {})
      end
      it 'connect to endpoint user picture' do
        expect(subject.user_picture(user_slug: 'abc'))
          .to have_requested(:get, 'https://app.fitbark.com/api/v2/picture/user/abc').once
      end
      it 'return an object Fitbark::Data::UserInfo' do
        expect(subject.user_picture(user_slug: 'abc')).to be_kind_of(Fitbark::Data::UserPicture)
      end
    end
    context 'when response has errors' do
      let!(:stub_response_error) { stub_webmock_error('picture/user/abc') }
      it 'raise an error Fitbark::Errors::ConnectionError' do
        expect { subject.user_picture(user_slug: 'abc') }
          .to raise_error(Fitbark::Errors::ConnectionError)
      end
    end
  end
end
