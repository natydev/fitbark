RSpec.describe Fitbark::Client do
  let!(:token) { random_token }
  let!(:user_info_response) { json_response(:user_info) }
  let(:subject) do
    described_class.new(token: token)
  end

  context 'init' do
    it 'return an object Fitbark::Client' do
      expect(subject).to be_kind_of(Fitbark::Client)
    end
  end
end
