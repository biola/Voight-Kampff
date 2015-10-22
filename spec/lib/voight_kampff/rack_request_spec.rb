require 'spec_helper'

describe Rack::Request do
  let(:user_agent_string) { }
  let(:env) { {'HTTP_USER_AGENT' => user_agent_string} }
  subject { Rack::Request.new(env) }

  it { expect(subject).to respond_to :human? }
  it { expect(subject).to respond_to :bot? }
  it { expect(subject).to respond_to :replicant? }

  HUMANS.each do |name, ua_string|
    context "when user agent is #{name}" do
      let(:user_agent_string) { ua_string }

      it 'is not a replicant' do
        expect(subject.human?).to eql true
        expect(subject.bot?).to eql false
      end
    end
  end

  REPLICANTS.each do |name, ua_string|
    context "when user agent is #{name}" do
      let(:user_agent_string) { ua_string }

      it 'is a replicant' do
        expect(subject.bot?).to eql true
        expect(subject.human?).to eql false
      end
    end
  end
end
