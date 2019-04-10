RSpec.describe Fitbark::Client do
  let!(:token) { random_token }
  let!(:dog_info_response) { json_response(:dog_info) }
  let(:subject) do
    described_class.new(token: token)
  end

  context 'dog_info' do
    context 'when response is success' do
      let!(:stub_webmock_success) do
        stub_request(:get, "#{api_uri_request}/dog/abc")
          .with(headers: api_headers_request(token))
          .to_return(status: 200, body:
            dog_info_response, headers: {})
      end
      it 'connect to endpoint user picture' do
        expect(subject.dog_info(dog_slug: 'abc'))
          .to have_requested(:get, 'https://app.fitbark.com/api/v2/dog/abc').once
      end
      it 'return an object Fitbark::Data::UserInfo' do
        expect(subject.dog_info(dog_slug: 'abc')).to be_kind_of(Fitbark::Data::DogInfo)
      end
    end
    context 'when response has errors' do
      let!(:stub_response_error) { stub_webmock_error('dog/abc') }
      it 'raise an error Fitbark::Errors::ConnectionError' do
        expect { subject.dog_info(dog_slug: 'abc') }
          .to raise_error(Fitbark::Errors::ConnectionError)
      end
    end
  end
end
