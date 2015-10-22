require 'rubygems'
require 'bundler'

Bundler.require :default, :development

Combustion.initialize! :action_controller
run Combustion::Application
