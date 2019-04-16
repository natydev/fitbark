RSpec.describe Fitbark::Client do
  let!(:token) { random_token }
  let!(:time_breakdown_response) { json_response(:time_breakdown) }
  let!(:tb_params) do
    {
      dog_slug: 'abc',
      from: Date.parse('2019-01-01'),
      to: Date.parse('2019-01-03')
    }
  end
  let!(:query_request) do
    {
      dog: {
        slug: 'abc',
        from: '2019-01-01',
        to: '2019-01-03'
      }
    }
  end
  let(:subject) do
    described_class.new(token: token)
  end

  context 'time_breakdown' do
    context 'when response is success' do
      let!(:stub_webmock_success) do
        stub_request(:post, "#{api_uri_request}/time_breakdown")
          .with(headers: api_headers_request(token))
          .with(query: query_request)
          .to_return(status: 200, body:
            time_breakdown_response, headers: {})
      end
      it 'connect to endpoint time_breakdown' do
        expect(subject.time_breakdown(tb_params))
          .to have_requested(:post, 'https://app.fitbark.com/api/v2/time_breakdown')
          .with(query: query_request).once
      end
      it 'return an Fitbark::Data::ActivityLevel' do
        expect(subject.time_breakdown(tb_params)).to be_kind_of(Fitbark::Data::ActivityLevel)
      end
    end
    context 'when response has errors' do
      let!(:stub_response_error) do
        stub_request(:any, 'https://app.fitbark.com/api/v2/time_breakdown')
          .with(headers: api_headers_request(token))
          .with(query: query_request)
          .to_return(status: 500, body:
            'something was wrong')
      end
      it 'raise an error Fitbark::Errors::ConnectionError' do
        expect { subject.time_breakdown(tb_params) }
          .to raise_error(Fitbark::Errors::ConnectionError)
      end
    end
  end
end
