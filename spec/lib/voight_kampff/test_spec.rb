# frozen_string_literal: true

require 'spec_helper'

describe VoightKampff::Test do
  let(:user_agent_string) { nil }
  subject { VoightKampff::Test.new(user_agent_string) }

  HUMANS.each do |name, ua_string|
    context "when user agent is #{name}" do
      let(:user_agent_string) { ua_string }

      it 'is not a replicant' do
        expect(subject.human?).to be true
        expect(subject.bot?).to be false
      end
    end
  end

  REPLICANTS.each do |name, ua_string|
    context "when user agent is #{name}" do
      let(:user_agent_string) { ua_string }

      it 'is a replicant' do
        expect(subject.bot?).to be true
        expect(subject.human?).to be false
      end
    end
  end

  context 'after the first run' do
    def time_of_run
      Benchmark.realtime { VoightKampff::Test.new('anything').bot? }
    end

    before do
      VoightKampff::Test.instance_variable_set(:@crawler_regexp, nil)
    end

    let(:number_of_runs) { 20 }

    times_faster = 2

    it "is at least #{times_faster} times faster" do
      expect(time_of_run / times_faster).to be > (
        (1..number_of_runs).map { time_of_run }.sum / number_of_runs
      )
    end
  end
end
