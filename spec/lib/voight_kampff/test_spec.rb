# frozen_string_literal: true

require 'spec_helper'

describe VoightKampff::Test do
  describe 'cache' do
    describe 'creating' do
      before do
        FileUtils.rm_rf cache_path if cache_path

        allow(described_class).to receive(:cache_path).and_return cache_path
      end

      shared_examples 'created after loading without cache' do
        it do
          expect(File.exist?(cache_path)).to be false

          described_class.load_crawlers

          expect(File.exist?(cache_path)).to be true
        end
      end

      context 'default cache_path' do
        let(:cache_path) { described_class.cache_path }

        it_behaves_like 'created after loading without cache'
      end

      context 'custom absolute cache_path' do
        after do
          FileUtils.rm_rf "#{Dir.pwd}/custom"
        end

        let(:cache_path) { "#{Dir.pwd}/custom/directory/with/file.json" }

        it_behaves_like 'created after loading without cache'
      end

      context 'custom relative cache_path' do
        after do
          FileUtils.rm_rf './custom'
        end

        let(:cache_path) { './custom/directory/with/file.json' }

        it_behaves_like 'created after loading without cache'
      end

      context 'without cache_path' do
        let(:cache_path) { nil }

        before do
          expect(File).not_to receive(:write)
        end

        it { described_class.load_crawlers }
      end
    end

    describe 'updating' do
      describe 'class instance variable' do
        before do
          described_class.crawlers

          described_class.instance_variable_set(
            :@last_updated_at, fake_updated_at
          )
        end

        context 'fresh' do
          let(:fake_updated_at) { Time.now - described_class.max_age + 1 }

          it do
            expect(described_class).not_to receive(:load_crawlers)
            described_class.crawlers
          end
        end

        context 'stale' do
          let(:fake_updated_at) { Time.now - described_class.max_age - 1 }

          it do
            expect(described_class).to receive(:load_crawlers).and_call_original
            described_class.crawlers
          end
        end
      end

      describe 'file' do
        before do
          described_class.load_crawlers

          allow(File).to receive(:mtime).with(described_class.cache_path)
            .and_return(fake_mtime)
        end

        context 'fresh' do
          let(:fake_mtime) { Time.now - described_class.max_age + 1 }

          it do
            expect(described_class).not_to receive(:load_remote_crawlers)
            described_class.load_crawlers
          end
        end

        context 'stale' do
          let(:fake_mtime) { Time.now - described_class.max_age - 1 }

          it do
            expect(described_class).to receive(:load_remote_crawlers)
              .and_call_original
            described_class.load_crawlers
          end
        end
      end
    end
  end

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

    let(:number_of_runs) { 20 }

    times_faster = 2

    it "is at least #{times_faster} times faster" do
      expect(time_of_run / times_faster).to be > (
        (1..number_of_runs).map { time_of_run }.sum / number_of_runs
      )
    end
  end
end
