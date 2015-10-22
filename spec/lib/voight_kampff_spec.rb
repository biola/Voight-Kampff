require 'spec_helper'

describe VoightKampff do
  subject { VoightKampff }

  HUMANS.each do |name, ua_string|
    context "when user agent is #{ua_string}" do
      let(:user_agent_string) { ua_string }

      it 'is not a replicant' do
        expect(subject.human?(user_agent_string)).to be true
        expect(subject.bot?(user_agent_string)).to be false
      end
    end
  end

  REPLICANTS.each do |name, ua_string|
    context "when user agent is #{ua_string}" do
      let(:user_agent_string) { ua_string }

      it 'is a replicant' do
        expect(subject.bot?(user_agent_string)).to be true
        expect(subject.human?(user_agent_string)).to be false
      end
    end
  end
end
