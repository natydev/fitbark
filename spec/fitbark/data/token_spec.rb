require 'fitbark/data/token'

RSpec.describe Fitbark::Data::Token do
  let(:access_token) { SecureRandom.hex(30).to_s }
  let(:token_type) { 'bearer' }
  let(:expires_in) { rand(3000..10_000) }
  let(:scope) { 'partners' }
  let(:raw_data) do
    {
      'access_token' => access_token,
      'token_type' => token_type,
      'expires_in' => expires_in,
      'scope' => scope
    }
  end
  let!(:subject) { described_class.new(raw_data) }
  it 'has attribute token' do
    expect(subject.token).to eq(access_token)
  end
  it 'has attribute expires_at' do
    expect(subject.expires_at).to be_kind_of(Time)
  end
  it 'has attribute type' do
    expect(subject.type).to eq(token_type)
  end
  it 'has attribute scopes' do
    expect(subject.scopes).to eq([scope])
  end
end
