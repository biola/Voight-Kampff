# frozen_string_literal: true

require_relative 'lib/voight_kampff/version'

Gem::Specification.new do |s|
  s.name = 'voight_kampff'
  s.summary     = 'Voight-Kampff bot detection'
  s.description = 'Voight-Kampff detects bots, spiders, crawlers and replicants'

  s.licenses    = ['MIT']

  s.author      = 'Adam Crownoble'
  s.email       = 'adam@codenoble.com'

  github_uri = 'https://github.com/biola/Voight-Kampff'

  s.homepage = github_uri

  s.metadata = {
    'bug_tracker_uri' => "#{github_uri}/issues",
    'documentation_uri' => "http://www.rubydoc.info/gems/#{s.name}/#{s.version}",
    'homepage_uri' => s.homepage,
    'rubygems_mfa_required' => 'true',
    'source_code_uri' => github_uri
  }

  s.version       = VoightKampff::VERSION
  s.files         = `git ls-files`.split("\n")
  s.require_path  = 'lib'

  s.required_ruby_version = '>= 2.4'

  s.add_development_dependency 'combustion', '~> 1.1'
  s.add_development_dependency 'pry-byebug', '~> 3.7'
  s.add_development_dependency 'rack', ['>= 1.4', '< 4.0']
  s.add_development_dependency 'rails', '>= 5.2', '< 8'
  s.add_development_dependency 'rspec-rails', '~> 6.0'
  s.add_development_dependency 'rubocop', '~> 1.48.0'
end
