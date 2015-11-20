module VoightKampff
  class Test
    CRAWLERS_FILENAME = 'crawler-user-agents.json'

    attr_accessor :user_agent_string

    def initialize(user_agent_string)
      @user_agent_string = user_agent_string
    end

    def agent
      @agent ||= crawlers.find do |crawler|
        self.user_agent_string =~ crawler['regexp']
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

    def crawlers
      @@crawlers ||= begin
        JSON.load(File.open(preferred_path, 'r')).map do |crawler|
          crawler['regexp'] = Regexp.new(crawler['pattern'], Regexp::IGNORECASE)
        end
      end
    end
  end
end
