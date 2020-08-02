require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :install do
  system("echo $PWD")
  system("gem build quick_study.gemspec")
  system("gem install quick_study-#{QuickStudy::VERSION}.gem")
end
