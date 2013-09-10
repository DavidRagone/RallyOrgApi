require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |task|
  task.libs << 'test'
  task.verbose = true
end

task default: :test
task spec: :test
