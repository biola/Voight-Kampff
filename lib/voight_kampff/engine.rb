require 'voight_kampff'
require 'rails'

module VoightKampff
  class Engine < Rails::Engine
  
    rake_tasks do
      load 'tasks/voight_kampff.rake'
    end
  
  end
end
