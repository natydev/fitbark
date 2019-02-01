require 'fitbark/data/token_info'

RSpec.describe Fitbark::Data::TokenInfo do
  let(:resource_owner_id) { '132' }
  let(:expires_in) { rand(3000..10_000) }
  let(:scope) { 'partners' }
  let(:uid) { '6b63e42f45c9c4cb54b87213ed0' }
  let(:raw_data) do
    {
      'resource_owner_id' => resource_owner_id,
      'scopes' => [scope],
      'expires_in_seconds' => expires_in,
      'application' => {
        'uid' => uid
      }
    }
  end
  let!(:subject) { described_class.new(raw_data) }
  it 'has attribute resource_owner_id' do
    expect(subject.resource_owner_id).to eq(resource_owner_id)
  end
  it 'has attribute scopes' do
    expect(subject.scopes).to eq([scope])
  end
  it 'has attribute expires_at' do
    expect(subject.expires_at).to be_kind_of(Time)
  end
  it 'has attribute application' do
    expect(subject.application)
      .to be_kind_of(Fitbark::Data::TokenInfo::Application)
  end
  context 'inside application' do
    it 'has attribute uid' do
      expect(subject.application.uid).to eq(uid)
    end
  end
end
