# frozen_string_literal: true

require 'net/http'
require 'json'

module VoightKampff
  # Test User-Agent against Voight-Kampff
  class Test
    DEFAULT_URL =
      'https://raw.githubusercontent.com/monperrus/crawler-user-agents/master/crawler-user-agents.json'
    CRAWLERS_FILENAME = File.basename(DEFAULT_URL).freeze

    class << self
      def cache_path
        @cache_path ||= "#{Dir.pwd}/tmp/#{CRAWLERS_FILENAME}"
      end

      def cache_path=(value)
        @cache_path = File.expand_path value
      end

      def max_age
        @max_age ||= 24 * 3600
      end

      attr_writer :max_age

      def crawlers
        return @crawlers if @crawlers && fresh?(@last_updated_at)

        @last_updated_at = Time.now
        @crawler_regexp = nil
        @crawlers = JSON.parse(load_crawlers)
      end

      def crawler_regexp
        @crawler_regexp ||= begin
          # NOTE: This is admittedly a bit convoluted
          # but the performance gains make it worthwhile
          crawler_patterns =
            crawlers.map.with_index do |crawler, index|
              "(?<match#{index}>#{crawler['pattern']})"
            end.join('|')
          crawler_patterns = "(#{crawler_patterns})"
          Regexp.new(crawler_patterns, Regexp::IGNORECASE)
        end
      end

      def load_crawlers
        load_local_crawlers || load_remote_crawlers
      end

      private

      def fresh?(timestamp)
        return false unless timestamp

        timestamp >= Time.now - max_age
      end

      def load_remote_crawlers(uri = DEFAULT_URL)
        crawlers = Net::HTTP.get(URI(uri)).force_encoding('UTF-8')
        if cache_path
          FileUtils.mkdir_p File.dirname cache_path
          File.write(cache_path, crawlers)
        end
        crawlers
      end

      def load_local_crawlers
        if cache_path && File.exist?(cache_path) &&
           fresh?(File.mtime(cache_path))
          File.read(cache_path)
        end
      end
    end

    attr_accessor :user_agent_string

    def initialize(user_agent_string)
      @user_agent_string = user_agent_string
    end

    def agent
      @agent ||= matching_crawler || {}
    end

    def human?
      agent.empty?
    end

    def bot?
      !human?
    end
    alias replicant? bot?

    private

    def matching_crawler
      match = self.class.crawler_regexp.match(@user_agent_string)
      return unless match&.names&.any?

      index = match.names.first.sub(/match/, '').to_i
      self.class.crawlers[index]
    end
  end
end
