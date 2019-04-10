RSpec.describe Fitbark::Client do
  let!(:token) { random_token }
  let!(:dog_picture_response) { json_response(:picture) }
  let(:subject) do
    described_class.new(token: token)
  end

  context 'dog_picture' do
    context 'when response is success' do
      let!(:stub_webmock_success) do
        stub_request(:get, "#{api_uri_request}/picture/dog/abc")
          .with(headers: api_headers_request(token))
          .to_return(status: 200, body:
            dog_picture_response, headers: {})
      end
      it 'connect to endpoint dog picture' do
        expect(subject.dog_picture(dog_slug: 'abc'))
          .to have_requested(:get, 'https://app.fitbark.com/api/v2/picture/dog/abc').once
      end
      it 'return an object Fitbark::Data::UserInfo' do
        expect(subject.dog_picture(dog_slug: 'abc')).to be_kind_of(Fitbark::Data::Picture)
      end
    end
    context 'when response has errors' do
      let!(:stub_response_error) { stub_webmock_error('picture/dog/abc') }
      it 'raise an error Fitbark::Errors::ConnectionError' do
        expect { subject.dog_picture(dog_slug: 'abc') }
          .to raise_error(Fitbark::Errors::ConnectionError)
      end
    end
  end
end
