require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |task|
  task.libs << 'lib/'
  task.test_files = FileList['test/lib/test_*.rb']
  task.verbose = true
end

task default: :test
task spec: :test
