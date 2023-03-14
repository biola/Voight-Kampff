# frozen_string_literal: true

require 'bundler/setup'
require 'pry-byebug'
require 'combustion'
require_relative '../lib/voight_kampff'
require_relative '../lib/voight_kampff/rails'

Combustion.initialize! :action_controller

require 'rspec/rails'
Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
