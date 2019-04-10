require 'fitbark/client'
require 'fitbark/errors'
require 'fitbark/constants'
require 'fitbark/handler/v2/base.rb'
require 'fitbark/handler/v2/dog_relations.rb'
require 'fitbark/data/shared.rb'
require 'fitbark/data/user_relation.rb'
require 'fitbark/data/dog_preview.rb'

RSpec.describe Fitbark::Client do
  let!(:token) { random_token }
  let!(:dog_relations_response) { json_response(:dog_relations) }
  let(:subject) do
    described_class.new(token: token)
  end

  context 'dog_relations' do
    context 'when response is success' do
      let!(:stub_webmock_success) do
        stub_request(:get, "#{api_uri_request}/dog_relations")
          .with(headers: api_headers_request(token))
          .to_return(status: 200, body:
            dog_relations_response, headers: {})
      end
      it 'connect to endpoint user info' do
        expect(subject.dog_relations)
          .to have_requested(:get, 'https://app.fitbark.com/api/v2/dog_relations').once
      end
      it 'return an object Fitbark::Data::UserInfo' do
        expect(subject.dog_relations).to be_kind_of(Array)
      end
    end
    context 'when response has errors' do
      let!(:stub_response_error) { stub_webmock_error('dog_relations') }
      it 'raise an error Fitbark::Errors::ConnectionError' do
        expect { subject.dog_relations }.to raise_error(Fitbark::Errors::ConnectionError)
      end
    end
  end
end
