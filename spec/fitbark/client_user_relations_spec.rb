RSpec.describe Fitbark::Client do
  let!(:token) { random_token }
  let!(:user_relations_response) { json_response(:user_relations) }
  let(:subject) do
    described_class.new(token: token)
  end

  context 'user_relations' do
    context 'when response is success' do
      let!(:stub_webmock_success) do
        stub_request(:get, "#{api_uri_request}/user_relations/abc")
          .with(headers: api_headers_request(token))
          .to_return(status: 200, body:
            user_relations_response, headers: {})
      end
      it 'connect to endpoint user info' do
        expect(subject.user_relations(dog_slug: 'abc'))
          .to have_requested(:get, 'https://app.fitbark.com/api/v2/user_relations/abc').once
      end
      it 'return an object Fitbark::Data::UserInfo' do
        expect(subject.user_relations(dog_slug: 'abc')).to be_kind_of(Array)
      end
    end
    context 'when response has errors' do
      let!(:stub_response_error) { stub_webmock_error('user_relations/abc') }
      it 'raise an error Fitbark::Errors::ConnectionError' do
        expect { subject.user_relations(dog_slug: 'abc') }
          .to raise_error(Fitbark::Errors::ConnectionError)
      end
    end
  end
end
