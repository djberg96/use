require 'rake'
require 'rake/testtask'

desc "Cleanup any .gem or .rbc files"
task :clean do
  Dir['*.gem'].each{ |f| File.delete(f) }
  Dir['**/*.rbc'].each{ |f| File.delete(f) } # Rubinius
end

namespace :gem do
  desc "Create the use gem"
  task :create => [:clean] do
    spec = eval(IO.read('use.gemspec'))
    Gem::Builder.new(spec).build
  end

  desc "Install the use gem"
  task :install => [:create] do
    file = Dir["*.gem"].first
    sh "gem install #{file}"
  end
end

Rake::TestTask.new do |t|
  task :test => :clean
  t.libs << 'test'
  t.verbose = true
  t.warning = true
end

task :default => :test
