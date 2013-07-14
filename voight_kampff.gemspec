# -*- encoding: utf-8 -*-
$:.unshift File.expand_path('../lib', __FILE__)
require 'voight_kampff/version'

Gem::Specification.new do |s|
  s.name = 'voight_kampff'
  s.summary     = "Voight-Kampff bot detection"
  s.description = 'Voight-Kampff detects bots, spiders, crawlers and replicants'

  s.licenses      = ['MIT']

  s.author      = "Adam Crownoble"
  s.email       = "adam@obledesign.com"
  s.homepage    = "https://github.com/biola/Voight-Kampff"

  # so that rubygems does not uses the actual object
  s.version       = VoightKampff::VERSION.dup
  s.platform      = Gem::Platform::RUBY.dup
  s.files         = `git ls-files`.split("\n")
  s.files.reject! { |fn| fn.match(/\.travis.yml/) }
  s.test_files    = `git ls-files -- {tests}/**/*`.split("\n")
  s.require_path  = 'lib'

  s.add_dependency 'httpclient', '~> 2.2'

  # Nokogiri 1.6.0 has dropped support for Ruby 1.8.7
  s.add_dependency 'nokogiri', (RUBY_VERSION.match("1.8.7") ? '1.5.10' : '~> 1.6.0')
  s.add_development_dependency 'minitest', '~> 4.7'
  s.add_development_dependency 'rdoc', '>= 2.4.2'
end
