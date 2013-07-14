#require 'bundler/setup'
require 'rake/testtask'

_PATTERN_ = 'tests/spec/**/*_spec.rb'

Bundler::GemHelper.install_tasks

task :default => :test

##
# Setup rake test in order to
# run minitest speclike tests
# libs << path.. to load {minitest, spec, test}_helper.rb
Rake::TestTask.new do |t|
  t.libs << 'tests/spec'
  t.pattern     = _PATTERN_
  t.test_files  = FileList[_PATTERN_]
  t.verbose     = false
end

