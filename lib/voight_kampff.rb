# frozen_string_literal: true

require 'voight_kampff/test'
require 'voight_kampff/methods'

# Class helper methods
module VoightKampff
  ROOT = File.expand_path '..', __dir__

  class << self
    def human?(user_agent_string)
      test(user_agent_string).human?
    end

    def bot?(user_agent_string)
      test(user_agent_string).bot?
    end
    alias replicant? bot?

    private

    def test(user_agent_string)
      VoightKampff::Test.new(user_agent_string)
    end
  end
end
