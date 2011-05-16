lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'voight_kampff/version'

spec = Gem::Specification.new do |s|
  s.name = 'voight_kampff'
  s.version = VoightKampff::VERSION
  s.summary = "Voight-Kampff bot detection"
  s.description = "Voight-Kampff is a Ruby gem that detects bots, spiders, crawlers and replicants"
  s.files = Dir['config/*', 'config/**/*.rb', 'lib/*.rb', 'lib/**/*.rb', 'lib/tasks/*.rake']
  s.require_path = 'lib'
  s.author = "Adam Crownoble"
  s.email = "adam@obledesign.com"
  s.homepage = "https://github.com/adamcrown/Voight-Kampff"
end
