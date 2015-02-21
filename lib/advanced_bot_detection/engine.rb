require 'advanced-bot-detection'
require 'rails'

module AdvancedBotDetection
  class Engine < Rails::Engine
    rake_tasks do
      load 'tasks/advanced_bot_detection.rake.rake'
    end
  end
end
