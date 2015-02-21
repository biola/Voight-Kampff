require 'advanced-bot-detection'
require 'rails'

module AdvancedBotDetection
  class Engine < Rails::Engine
    rake_tasks do
      load 'tasks/advanced-bot-detection.rake'
    end
  end
end
