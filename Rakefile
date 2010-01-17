require 'rake'
require 'rake/testtask'
require 'rbconfig'
include Config

desc 'Install the use package (non-gem)'
task :install do
   sitelibdir = CONFIG["sitelibdir"]
   file = "lib/use.rb"
   FileUtils.cp(file, sitelibdir, :verbose => true)
end

task :gem do
   spec = eval(IO.read('use.gemspec'))
   Gem::Builder.new(spec).buildend

task :install_gem => [:gem] do
   file = Dir["*.gem"].first
   sh "gem install #{file}"
end

Rake::TestTask.new do |t|
   t.libs << 'test'
   t.verbose = true
   t.warning = true
end
