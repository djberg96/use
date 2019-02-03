require 'rubygems'

Gem::Specification.new do |spec|
  gem.name      = 'use'
  gem.version   = '1.4.0'
  gem.author    = 'Daniel J. Berger'
  gem.license   = 'Apache-2.0'
  gem.email     = 'djberg96@gmail.com'
  gem.homepage  = 'https://github.com/djberg96/use'
  gem.summary   = 'Selectively mixin methods from a given module'
  gem.test_file = 'test/test_use.rb'
  gem.files     = Dir['**/*'].reject{ |f| f.include?('git') }

  gem.extra_rdoc_files  = ['MANIFEST', 'README', 'CHANGES']

  gem.add_dependency('structured_warnings', '~> 0.3.0')
  gem.add_development_dependency('rake')

  gem.description = <<-EOF
    The use library solves the multi-mixin problem by allowing you to
    selectively mixin specific methods from a module rather than mixing in
    all of them. In addition, you can alias methods on the fly as they are
    mixed in, effectively allowing you to change the name of the mixin method.
  EOF
end
