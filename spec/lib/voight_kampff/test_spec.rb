require 'spec_helper'

describe VoightKampff::Test do
  before(:each) do
    VoightKampff::Test.class_variable_set :@@crawler_regexp, nil
    VoightKampff::Test.class_variable_set :@@crawlers, nil
  end

  after(:each) do
    VoightKampff::Test.class_variable_set :@@crawler_regexp, nil
    VoightKampff::Test.class_variable_set :@@crawlers, nil
  end

  context 'with default patterns loaded' do
    let(:user_agent_string) { nil }
    subject { VoightKampff::Test.new(user_agent_string) }

    HUMANS.each do |name, ua_string|
      context "when user agent is #{name}" do
        let(:user_agent_string) { ua_string }

        it 'is not a replicant' do
          expect(subject.human?).to be true
          expect(subject.bot?).to be false
          expect(subject.bot?(:bad)).to be false
        end
      end
    end

    REPLICANTS.each do |name, ua_string|
      context "when user agent is #{name}" do
        let(:user_agent_string) { ua_string }

        it 'is a replicant' do
          expect(subject.bot?).to be true
          expect(subject.bot?(:bad)).to be true
          expect(subject.human?).to be false
        end
      end
    end

    context 'after the first run' do
      before { VoightKampff::Test.new('anything').bot? }

      it 'is fast' do
        expect(
          Benchmark.realtime do
            20.times { VoightKampff::Test.new('anything').bot? }
          end
        ).to be < 0.004
      end
    end
  end

  context 'with custom patterns loaded' do
    let(:current_directory) {
      File.expand_path '.', File.dirname(__FILE__)
    }

    before(:each) do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with('VOIGHT_KAMPFF_ROOT').and_return(current_directory)
    end


    let(:user_agent_string) { nil }
    subject { VoightKampff::Test.new(user_agent_string) }

    context 'using user agent described by custom patterns' do
      let(:user_agent_string) { 'Googlebot/2.1 (+http://www.google.com/bot.html)' }

      it 'gets detected as a bot' do
        expect(subject.bot?).to be true
        expect(subject.human?).to be false
      end
    end

    context 'using user agent not described by custom patterns' do
      let(:user_agent_string) {
        'DoCoMo/2.0 N905i(c100;TB;W24H16) (compatible; Googlebot-Mobile/2.1; +http://www.google.com/bot.html)'
      }

      it 'gets detected as a human' do
        expect(subject.bot?).to be false
        expect(subject.human?).to be true
      end
    end
  end
end
