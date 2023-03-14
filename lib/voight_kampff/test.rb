# frozen_string_literal: true

module VoightKampff
  # Test User-Agent against Voight-Kampff
  class Test
    CRAWLERS_FILENAME = 'crawler-user-agents.json'

    class << self
      def crawlers
        @crawlers ||= JSON.parse File.read preferred_path
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

      private

      def lookup_paths
        # These paths should be orderd by priority
        [
          (Rails.root if defined? Rails),
          Dir.pwd,
          VoightKampff::ROOT
        ]
      end

      def preferred_path
        lookup_paths.find do |base_path|
          next unless base_path

          path = File.join base_path, 'tmp', CRAWLERS_FILENAME

          break path if File.exist? path
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
      return unless match

      index = match.names.first.sub(/match/, '').to_i
      self.class.crawlers[index]
    end
  end
end
