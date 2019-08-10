# frozen_string_literal: true

require 'bundler/setup'
require 'pry-byebug'
require 'combustion'
require_relative '../lib/voight_kampff'

Combustion.initialize! :action_controller

require 'rspec/rails'
Dir['./spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.before do
    allow(Net::HTTP).to receive(:get).with(URI(VoightKampff::Test::DEFAULT_URL))
      .and_return File.read("#{__dir__}/fixtures/crawler-user-agents.json")
  end

  config.after(:suite) do
    FileUtils.rm_rf VoightKampff::Test.cache_path
  end
end
