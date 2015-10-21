require 'spec_helper'

describe VoightKampff::Test do
  let(:user_agent_string) { nil }
  subject { VoightKampff::Test.new(user_agent_string) }

  context 'when user_agent_string is nil' do
    let(:user_agent_string) { nil }

    it 'assumes the agent is not a replicant' do
      expect(subject.human?).to be true
      expect(subject.bot?).to be false
    end
  end

  context 'when Googlebot' do
    let(:user_agent_string) { 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)' }

    it 'is a replicant' do
      expect(subject.bot?).to be true
      expect(subject.human?).to be false
    end
  end

  context 'when Bingbot' do
    let(:user_agent_string) { 'Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)' }

    it 'is a replicant' do
      expect(subject.bot?).to be true
      expect(subject.human?).to be false
    end
  end

  context 'when Yahoo! Slurp' do
    let(:user_agent_string) { 'Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)' }

    it 'is a replicant' do
      expect(subject.bot?).to be true
      expect(subject.human?).to be false
    end
  end

  context 'when Chrome' do
    let(:user_agent_string) { 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36' }

    it 'is not a replicant' do
      expect(subject.human?).to be true
      expect(subject.bot?).to be false
    end
  end

  context 'when Firefox' do
    let(:user_agent_string) { 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1' }

    it 'is not a replicant' do
      expect(subject.human?).to be true
      expect(subject.bot?).to be false
    end
  end

  context 'when Safari' do
    let(:user_agent_string) { 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A' }

    it 'is not a replicant' do
      expect(subject.human?).to be true
      expect(subject.bot?).to be false
    end
  end

  context 'when IE' do
    let(:user_agent_string) { 'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; AS; rv:11.0) like Gecko' }

    it 'is not a replicant' do
      expect(subject.human?).to be true
      expect(subject.bot?).to be false
    end
  end

  context 'when Chrome mobile' do
    let(:user_agent_string) { 'Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19' }

    it 'is not a replicant' do
      expect(subject.human?).to be true
      expect(subject.bot?).to be false
    end
  end

  context 'when Safari for iOS' do
    let(:user_agent_string) { 'Mozilla/5.0 (iPad; CPU OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53' }

    it 'is not a replicant' do
      expect(subject.human?).to be true
      expect(subject.bot?).to be false
    end
  end
end
