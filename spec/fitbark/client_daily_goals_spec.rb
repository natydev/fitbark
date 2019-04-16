RSpec.describe Fitbark::Client do
  let!(:token) { random_token }
  let!(:daily_goals_response) { json_response(:daily_goals) }
  let(:subject) do
    described_class.new(token: token)
  end

  context 'daily_goals' do
    context 'when response is success' do
      let!(:stub_webmock_success) do
        stub_request(:get, "#{api_uri_request}/daily_goal/abc")
          .with(headers: api_headers_request(token))
          .to_return(status: 200, body:
            daily_goals_response, headers: {})
      end
      it 'connect to endpoint daily_goals' do
        expect(subject.daily_goals(dog_slug: 'abc'))
          .to have_requested(:get, 'https://app.fitbark.com/api/v2/daily_goal/abc').once
      end
      it 'return an object Array' do
        expect(subject.daily_goals(dog_slug: 'abc')).to be_kind_of(Array)
      end
      it 'each item of returned array is an object Fitbark::Data::DailyGoal' do
        expect(subject.daily_goals(dog_slug: 'abc').first)
          .to be_kind_of(Fitbark::Data::DailyGoal)
      end
    end
    context 'when response has errors' do
      let!(:stub_response_error) { stub_webmock_error('daily_goal/abc') }
      it 'raise an error Fitbark::Errors::ConnectionError' do
        expect { subject.daily_goals(dog_slug: 'abc') }
          .to raise_error(Fitbark::Errors::ConnectionError)
      end
    end
  end
end
