require "bundler/gem_tasks"
require "rspec/core/rake_task"

Rake::TestTask.new do |task|
  task.libs << 'test'
  task.verbose = true
end

task default: :test
task spec: :test
