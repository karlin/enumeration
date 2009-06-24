require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'
require 'rake/clean'

Rake::RDocTask.new do |task|
  task.rdoc_files.add [ 'lib/**/*.rb' ]
end

task :default => [ :clean, :spec ]

Spec::Rake::SpecTask.new do |task|
  task.ruby_opts << '-rrubygems'
  task.libs << 'lib'
  task.spec_files = FileList[ "spec/**/*_spec.rb" ]
end

