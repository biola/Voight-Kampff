require 'spec_helper'

describe ReplicantsController, type: :controller do
  let(:ua_string) { '' }
  before do
    expect(request).to receive(:user_agent).and_return ua_string
    get :index
  end

  context 'when not a bot' do
    it 'is forbidden' do
      expect(response.status).to eql 403
    end
  end

  context 'when a bot' do
    let(:ua_string) { 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)' }

    it 'is successful' do
      expect(response.status).to eql 200
    end
  end
end
