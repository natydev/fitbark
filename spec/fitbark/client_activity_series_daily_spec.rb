RSpec.describe Fitbark::Client do
  let!(:token) { random_token }
  let!(:activity_series_daily_response) { json_response(:activity_series_daily) }
  let!(:as_params) do
    {
      dog_slug: 'abc',
      from: Date.parse('2019-01-01'),
      to: Date.parse('2019-01-03'),
      resolution: :daily
    }
  end
  let!(:query_request) do
    {
      activity_series: {
        slug: 'abc',
        from: '2019-01-01',
        to: '2019-01-03',
        resolution: 'DAILY'
      }
    }
  end
  let(:subject) do
    described_class.new(token: token)
  end

  context 'activity_series (daily)' do
    context 'when response is success' do
      let!(:stub_webmock_success) do
        stub_request(:post, "#{api_uri_request}/activity_series")
          .with(headers: api_headers_request(token))
          .with(query: query_request)
          .to_return(status: 200, body:
            activity_series_daily_response, headers: {})
      end
      it 'connect to endpoint activity_series' do
        expect(subject.activity_series(as_params))
          .to have_requested(:post, 'https://app.fitbark.com/api/v2/activity_series')
          .with(query: query_request).once
      end
      it 'return an object Array' do
        expect(subject.activity_series(as_params)).to be_kind_of(Array)
      end
      it 'each item inside array is kind Fitbark::Data::ActivityDaily' do
        expect(subject.activity_series(as_params).first)
          .to be_kind_of(Fitbark::Data::ActivityDaily)
      end
    end
    context 'when response has errors' do
      let!(:stub_response_error) do
        stub_request(:any, 'https://app.fitbark.com/api/v2/activity_series')
          .with(headers: api_headers_request(token))
          .with(query: query_request)
          .to_return(status: 500, body:
            'something was wrong')
      end
      it 'raise an error Fitbark::Errors::ConnectionError' do
        expect { subject.activity_series(as_params) }
          .to raise_error(Fitbark::Errors::ConnectionError)
      end
    end
  end
end
