require 'rake'
require 'shoulda/tasks'
require 'rake/testtask'
require 'bundler'

Bundler::GemHelper.install_tasks

task :default => :test

Rake::TestTask.new(:test) do |test|
  test.ruby_opts = ["-rubygems"] if defined?(Gem)
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
end
