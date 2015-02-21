# require 'bundler/setup'
require 'rake/testtask'

PATTERN = 'tests/spec/**/*_spec.rb'

Bundler::GemHelper.install_tasks

task default: :test

##
# Setup rake test in order to
# run minitest speclike tests
# libs << path.. to load {minitest, spec, test}_helper.rb
Rake::TestTask.new do |t|
  t.libs << 'tests/spec'
  t.pattern     = PATTERN
  t.test_files  = FileList[PATTERN]
  t.verbose     = false
end
