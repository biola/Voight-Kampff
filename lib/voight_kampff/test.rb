module VoightKampff
  class Test
    CRAWLERS_FILENAME = 'crawler-user-agents.json'

    attr_accessor :user_agent_string

    def initialize(user_agent_string)
      @user_agent_string = user_agent_string
    end

    def agent
      load_crawlers

      @agent ||= @@crawlers.find do |crawler|
        @user_agent_string =~ Regexp.new(crawler['pattern'], Regexp::IGNORECASE)
      end || {}
    end

    def human?
      agent.empty?
    end

    def bot?
      !human?
    end
    alias :replicant? :bot?

    private

    def lookup_paths
      # These paths should be orderd by priority
      base_paths = []
      base_paths << Rails.root if defined? Rails
      base_paths << VoightKampff.root

      base_paths.map { |p| p.join('config', CRAWLERS_FILENAME) }
    end

    def preferred_path
      lookup_paths.find { |path| File.exists? path }
    end

    def load_crawlers
      @@crawlers ||= JSON.load(File.open(preferred_path, 'r'))
    end
  end
end
