RSpec.describe Fitbark::Client do
  let!(:token) { random_token }
  let!(:date_today) { Date.today }
  let!(:daily_goals_response) { json_response(:daily_goals) }
  let!(:sdg_params) do
    {
      dog_slug: 'abc',
      set_on: Date.parse(date_today.to_s),
      goal_points: 12_000
    }
  end
  let!(:query_request) do
    {
      date: date_today.to_s,
      daily_goal: '12000'
    }
  end
  let(:subject) do
    described_class.new(token: token)
  end

  context 'set_daily_goal' do
    context 'when response is success' do
      let!(:stub_webmock_success) do
        stub_request(:put, "#{api_uri_request}/daily_goal/abc")
          .with(headers: api_headers_request(token))
          .with(query: query_request)
          .to_return(status: 200, body:
            daily_goals_response, headers: {})
      end
      it 'connect to endpoint daily_goals' do
        expect(subject.set_daily_goal(sdg_params))
          .to have_requested(:put, 'https://app.fitbark.com/api/v2/daily_goal/abc')
          .with(query: query_request).once
      end
      it 'return an object Array' do
        expect(subject.set_daily_goal(sdg_params)).to be_kind_of(Array)
      end
      it 'each item of returned array is an object Fitbark::Data::DailyGoal' do
        expect(subject.set_daily_goal(sdg_params).first)
          .to be_kind_of(Fitbark::Data::DailyGoal)
      end
    end
    context 'when response has errors' do
      let!(:stub_response_error) do
        stub_request(:put, 'https://app.fitbark.com/api/v2/daily_goal/abc')
          .with(headers: api_headers_request(token))
          .with(query: query_request)
          .to_return(status: 500, body:
            'something was wrong')
      end
      it 'raise an error Fitbark::Errors::ConnectionError' do
        expect { subject.set_daily_goal(sdg_params) }
          .to raise_error(Fitbark::Errors::ConnectionError)
      end
    end
  end
end
