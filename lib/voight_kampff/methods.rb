# frozen_string_literal: true

module VoightKampff
  # Helper for Rack::Request
  module Methods
    extend Forwardable
    def_delegators :voight_kampff, :human?, :bot?, :replicant?

    private

    def voight_kampff
      VoightKampff::Test.new(user_agent)
    end
  end
end
