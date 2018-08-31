# frozen_string_literal: true

module VoightKampff
  # Integration with Rails
  class Engine < Rails::Engine
    rake_tasks do
      load 'tasks/voight_kampff.rake'
    end

    initializer :add_voight_kampff_methods do |_app|
      ActionDispatch::Request.class_eval do
        include VoightKampff::Methods
      end
    end
  end
end
