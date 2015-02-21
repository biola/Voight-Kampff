namespace :'advanced-bot-detection' do
  desc 'Import a new uesr_agents.yml file'
  task :import_user_agents, :url do |_t, args|
    args.with_defaults url: 'http://www.user-agents.org/allagents.xml'
    agents = AdvancedBotDetection::UserAgentsParser.new(args[:url])

    file = File.open(Rails.root.join('config', 'user_agents.yml'), 'w')
    file.write(agents.to_yaml)
  end
end
