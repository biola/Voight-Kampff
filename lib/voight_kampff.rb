require 'voight_kampff/test'
require 'voight_kampff/user_agents_parser'
require 'voight_kampff/engine' if defined?(Rails)

module VoightKampff

  class << self

    def root
      Pathname.new File.expand_path '..', File.dirname(__FILE__)
    end

    def human?(user_agent_string)
      test(user_agent_string).human?
    end
    
    def bot?(user_agent_string)
      test(user_agent_string).bot?
    end
    alias :replicant? :bot?

    def browser?(user_agent_string)
      test(user_agent_string).browser?
    end

    def checker?(user_agent_string)
      test(user_agent_string).checker?
    end
    
    def downloader?(user_agent_string)
      test(user_agent_string).downloader?
    end
    
    def proxy?(user_agent_string)
      test(user_agent_string).proxy?
    end

    def crawler?(user_agent_string)
      test(user_agent_string).crawler?
    end

    def spam?(user_agent_string)
      test(user_agent_string).spam?
    end

    private
    
    def test(user_agent_string)
      VoightKampff::Test.new(user_agent_string)
    end

  end

end
