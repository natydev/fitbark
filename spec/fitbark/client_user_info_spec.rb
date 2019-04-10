RSpec.describe Fitbark::Client do
  let!(:token) { random_token }
  let!(:user_info_response) { json_response(:user_info) }
  let(:subject) do
    described_class.new(token: token)
  end

  context 'user_info' do
    context 'when response is success' do
      let!(:stub_webmock_success) do
        stub_request(:get, "#{api_uri_request}/user")
          .with(headers: api_headers_request(token))
          .to_return(status: 200, body:
            user_info_response, headers: {})
      end
      it 'connect to endpoint user info' do
        expect(subject.user_info)
          .to have_requested(:get, 'https://app.fitbark.com/api/v2/user').once
      end
      it 'return an object Fitbark::Data::UserInfo' do
        expect(subject.user_info).to be_kind_of(Fitbark::Data::UserInfo)
      end
    end
    context 'when response has errors' do
      let!(:stub_response_error) { stub_webmock_error('user') }
      it 'raise an error Fitbark::Errors::ConnectionError' do
        expect { subject.user_info }.to raise_error(Fitbark::Errors::ConnectionError)
      end
    end
  end
end
