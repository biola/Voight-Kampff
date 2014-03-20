module VoightKampff

  class Test

    attr_accessor :user_agent_string
    attr_accessor :types

    def initialize(user_agent_string)
      load_agents
      @user_agent_string = user_agent_string
      @types = Array(agent['types']).map(&:to_sym)
      @description = agent['description']
    end

    def agent
      @agent ||= @@agents.find do |agent|
        if agent['string_match'] == 'regex'
          @user_agent_string =~ Regexp.new(agent['string'], Regexp::IGNORECASE)
        else
          @user_agent_string.to_s.casecmp(agent['string'].to_s) == 0
        end
      end || {}
    end

    def has_type?(*types)
      return nil if agent.empty?

      types.any? do |type|
        @types.include? type
      end
    end

    def human?
      has_type? :browser, :downloader, :proxy
    end

    def bot?
      has_type? :checker, :crawler, :spam
    end
    alias :replicant? :bot?

    def browser?
      has_type? :browser
    end

    def checker?
      has_type? :checker
    end

    def downloader?
      has_type? :downloader
    end

    def proxy?
      has_type? :proxy
    end

    def crawler?
      has_type? :crawler
    end

    def spam?
      has_type? :spam
    end

    private

    def load_agents
      @@agents ||= []
      if @@agents.empty?

        base_paths = []
        base_paths << Rails.root if defined? Rails
        base_paths << VoightKampff.root
        rel_path = ['config', 'user_agents.yml']

        base_paths.any? do |base_path|
          if File.exists? base_path.join(*rel_path)
            @@agents = YAML.load(File.open(base_path.join(*rel_path), 'r'))
          end
        end

      end
    end

  end

end
