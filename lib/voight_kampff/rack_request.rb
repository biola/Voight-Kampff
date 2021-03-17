# frozen_string_literal: true

# Reopen the Rack::Request class to add bot detection methods
Rack::Request.include VoightKampff::Methods if defined?(Rack::Request)
