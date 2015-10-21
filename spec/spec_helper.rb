require 'bundler/setup'
require 'combustion'
require 'voight_kampff'

Combustion.initialize! :action_controller, :action_view

require 'rspec/rails'
Dir['./spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
end
