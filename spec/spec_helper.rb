require 'bundler/setup'
require 'combustion'
require 'voight_kampff'

Combustion.initialize! :action_controller, :action_view

require 'rspec/rails'

RSpec.configure do |config|
end
