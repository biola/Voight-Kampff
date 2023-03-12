# -*- encoding: utf-8 -*-
$:.unshift File.expand_path('../lib', __FILE__)
require 'voight_kampff/version'

Gem::Specification.new do |s|
  s.name = 'voight_kampff'
  s.summary     = "Voight-Kampff bot detection"
  s.description = 'Voight-Kampff detects bots, spiders, crawlers and replicants'

  s.licenses      = ['MIT']

  s.author      = "Adam Crownoble"
  s.email       = "adam@codenoble.com"
  s.homepage    = "https://github.com/biola/Voight-Kampff"

  # so that rubygems does not uses the actual object
  s.version       = VoightKampff::VERSION.dup
  s.platform      = Gem::Platform::RUBY.dup
  s.files         = `git ls-files`.split("\n")
  s.files.reject! { |fn| fn.match(/\.travis.yml/) }
  s.test_files    = `git ls-files -- {tests}/**/*`.split("\n")
  s.require_path  = 'lib'

  s.add_dependency 'rack', ['>= 1.4']

  s.add_development_dependency 'combustion', '~> 1.1'
  s.add_development_dependency 'rails', '>= 5.2'
  s.add_development_dependency 'rspec-rails', '~> 3.8'
end
