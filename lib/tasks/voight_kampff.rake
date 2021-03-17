# frozen_string_literal: true

namespace :voight_kampff do
  desc 'Import a new crawler-user-agents.json file'
  task :import_user_agents, :url do |_t, args|
    args.with_defaults url: 'https://raw.githubusercontent.com/monperrus/crawler-user-agents/master/crawler-user-agents.json'

    require 'net/http'

    uri = URI(args[:url])
    contents = Net::HTTP.get(uri)

    if contents.present?
      File.write(
        './tmp/crawler-user-agents.json',
        contents.force_encoding(Encoding::UTF_8)
      )
    else
      puts "voight_kampff:import_user_agents - empty file received from #{uri}"
    end
  end
end
