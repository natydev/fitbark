RSpec.describe Fitbark::Client do
  let!(:token) { random_token }
  let!(:dog_relations_response) { json_response(:dog_relations) }
  let(:subject) do
    described_class.new(token: token)
  end

  context 'own_dogs' do
    context 'when response is success' do
      let!(:stub_webmock_success) do
        stub_request(:get, "#{api_uri_request}/dog_relations")
          .with(headers: api_headers_request(token))
          .to_return(status: 200, body:
            dog_relations_response, headers: {})
      end
      it 'connect to endpoint user info' do
        expect(subject.own_dogs)
          .to have_requested(:get, 'https://app.fitbark.com/api/v2/dog_relations').once
      end
      it 'return an object Array' do
        expect(subject.own_dogs).to be_kind_of(Array)
      end
      it 'returned array has one item' do
        expect(subject.own_dogs.size).to eq(1)
      end
      it 'each item inside array is kind Fitbark::Data::DogInfo' do
        expect(subject.own_dogs.first)
          .to be_kind_of(Fitbark::Data::DogInfo)
      end
    end
    context 'when response has errors' do
      let!(:stub_response_error) { stub_webmock_error('dog_relations') }
      it 'raise an error Fitbark::Errors::ConnectionError' do
        expect { subject.own_dogs }.to raise_error(Fitbark::Errors::ConnectionError)
      end
    end
  end
end
