require 'bundler/setup'
require 'combustion'
require 'voight_kampff'
require 'byebug'

Combustion.initialize! :action_controller

require 'rspec/rails'
Dir['./spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
end
