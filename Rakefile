gem 'rdoc'
require 'rdoc/task'
require 'rspec/core/rake_task'
require 'rake/clean'

RDoc::Task.new do |task|
  task.rdoc_files.add [ 'lib/**/*.rb' ]
end

task :default => [ :clean, :spec ]

RSpec::Core::RakeTask.new :spec

