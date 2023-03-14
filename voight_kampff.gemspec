# frozen_string_literal: true

require_relative 'lib/voight_kampff/version'

Gem::Specification.new do |s|
  s.name = 'voight_kampff'
  s.summary     = 'Voight-Kampff bot detection'
  s.description = 'Voight-Kampff detects bots, spiders, crawlers and replicants'

  s.licenses    = ['MIT']

  s.author      = 'Adam Crownoble'
  s.email       = 'adam@codenoble.com'
  s.homepage    = 'https://github.com/biola/Voight-Kampff'

  s.version       = VoightKampff::VERSION
  s.files         = `git ls-files`.split("\n")
  s.files.reject! { |fn| fn.match(/\.travis.yml/) }
  s.test_files    = `git ls-files -- spec/**/*`.split("\n")
  s.require_path  = 'lib'

  s.required_ruby_version = '>= 2.4'

  s.add_development_dependency 'combustion', '~> 1.1'
  s.add_development_dependency 'pry-byebug', '~> 3.7'
  s.add_development_dependency 'rack', ['>= 1.4', '< 4.0']
  s.add_development_dependency 'rails', '>= 5.2', '< 7'
  s.add_development_dependency 'rspec-rails', '~> 5.0'
  s.add_development_dependency 'rubocop', '~> 0.89.0'
end
