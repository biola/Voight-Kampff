require 'json'

require 'voight_kampff/test'
require 'voight_kampff/methods'

module VoightKampff
  class << self
    def root
      require 'pathname'
      Pathname.new File.expand_path '..', File.dirname(__FILE__)
    end

    def human?(user_agent_string)
      test(user_agent_string).human?
    end

    def bot?(user_agent_string)
      test(user_agent_string).bot?
    end
    alias :replicant? :bot?

    private

    def test(user_agent_string)
      VoightKampff::Test.new(user_agent_string)
    end
  end
end
