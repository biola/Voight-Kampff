require 'voight_kampff'
require 'rails'
require 'active_record'

module VoightKampff
  class Engine < Rails::Engine
  
    rake_tasks do
      load 'tasks/voight_kampff.rake'
    end
  
  end
end
