require 'rake'
require 'rake/clean'
require 'rake/testtask'

CLEAN.include("**/*.gem", "**/*.rbc", "**/*.rbx")

namespace :gem do
  desc "Create the use gem"
  task :create => [:clean] do
    spec = eval(IO.read('use.gemspec'))
    if Gem::VERSION < "2.0"
      Gem::Builder.new(spec).build
    else
      require 'rubygems/package'
      Gem::Package.build(spec)
    end
  end

  desc "Install the use gem"
  task :install => [:create] do
    file = Dir["*.gem"].first
    sh "gem install -l #{file}"
  end
end

Rake::TestTask.new do |t|
  task :test => :clean
  t.libs << 'test'
  t.verbose = true
  t.warning = true
end

task :default => :test
