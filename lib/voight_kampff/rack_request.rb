# Reopen the Rack::Request class to add bot detection methods
Rack::Request.class_eval do
  include VoightKampff::Methods
end
