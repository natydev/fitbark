RSpec.describe Fitbark::Client do
  let!(:token) { random_token }
  let!(:similar_dogs_stats_response) { json_response(:similar_dogs_stats) }
  let(:subject) do
    described_class.new(token: token)
  end

  context 'similar_dogs_stats' do
    context 'when response is success' do
      let!(:stub_webmock_success) do
        stub_request(:post, "#{api_uri_request}/similar_dogs_stats")
          .with(headers: api_headers_request(token))
          .with(query: { slug: 'abc' })
          .to_return(status: 200, body:
            similar_dogs_stats_response, headers: {})
      end
      it 'connect to endpoint similar_dogs_stats' do
        expect(subject.similar_dogs_stats(dog_slug: 'abc'))
          .to have_requested(:post, 'https://app.fitbark.com/api/v2/similar_dogs_stats')
          .with(query: { slug: 'abc' }).once
      end
      it 'return an object Fitbark::Data::SimilarDogsStat' do
        expect(subject.similar_dogs_stats(dog_slug: 'abc'))
          .to be_kind_of(Fitbark::Data::SimilarDogsStat)
      end
    end
    context 'when response has errors' do
      let!(:stub_response_error) do
        stub_request(:any, 'https://app.fitbark.com/api/v2/similar_dogs_stats')
          .with(headers: api_headers_request(token))
          .with(query: { slug: 'abc' })
          .to_return(status: 500, body:
            'something was wrong')
      end
      it 'raise an error Fitbark::Errors::ConnectionError' do
        expect { subject.similar_dogs_stats(dog_slug: 'abc') }
          .to raise_error(Fitbark::Errors::ConnectionError)
      end
    end
  end
end
