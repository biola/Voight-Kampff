# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'advanced_bot_detection/version'

Gem::Specification.new do |s|
  s.name        = 'advanced_bot_detection'
  s.version     = AdvancedBotDetection::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = 'Jeffery Yeary'
  s.email       = 'jeffery.yeary@gmail.com'
  s.homepage    = 'https://github.com/usbsnowcrash/advanced-bot-detection'
  s.summary     = 'advanced bot detection'
  s.description = 'Detects bots, spiders, crawlers, browsers, mobile devices and classify them'
  s.license     = 'MIT'

  s.files        = Dir['{lib}/**/*', 'config/**/*', 'MIT-LICENSE', '*.md']
  s.require_path = 'lib'

  s.add_dependency 'httpclient', '~> 2.2'
  s.add_dependency 'nokogiri', '~> 1.6'
  s.add_development_dependency 'minitest', '~> 4.7'
end
