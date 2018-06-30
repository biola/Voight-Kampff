namespace :voight_kampff do
  desc 'Import a new crawler-user-agents.json file'
  task :import_user_agents, :url do |t, args|
    args.with_defaults url: 'https://raw.githubusercontent.com/monperrus/crawler-user-agents/master/crawler-user-agents.json'

    require 'net/http'

    uri = URI(args[:url])
    contents = Net::HTTP.get(uri)

    if contents.present?
      file = File.open('./config/crawler-user-agents.json', 'w')
      file.write(contents.force_encoding(Encoding::UTF_8))
    else
      puts "voight_kampff:import_user_agents - empty file received from #{uri}"
    end
  end
end
