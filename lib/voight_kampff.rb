require 'json'
require 'pathname'

require 'voight_kampff/test'
require 'voight_kampff/methods'
require 'voight_kampff/rack_request' if defined?(Rack::Request)
require 'voight_kampff/engine' if defined?(Rails::Engine)

module VoightKampff
  class << self
    def root
      Pathname.new File.expand_path '..', File.dirname(__FILE__)
    end

    def custom_root
      Pathname.new custom_root_path
    end

    def custom_root?
      !custom_root_path.nil?
    end

    def human?(user_agent_string)
      test(user_agent_string).human?
    end

    def bot?(user_agent_string)
      test(user_agent_string).bot?
    end
    alias :replicant? :bot?

    private

    def custom_root_path
      ENV['VOIGHT_KAMPFF_ROOT']
    end

    def test(user_agent_string)
      VoightKampff::Test.new(user_agent_string)
    end
  end
end
