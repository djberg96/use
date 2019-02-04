require 'rubygems'

Gem::Specification.new do |spec|
  spec.name       = 'use'
  spec.version    = '1.4.0'
  spec.author     = 'Daniel J. Berger'
  spec.license    = 'Apache-2.0'
  spec.email      = 'djberg96@gmail.com'
  spec.homepage   = 'https://github.com/djberg96/use'
  spec.summary    = 'Selectively mixin methods from a given module'
  spec.test_file  = 'test/test_use.rb'
  spec.files      = Dir['**/*'].reject{ |f| f.include?('git') }
  spec.cert_chain = ['certs/djberg96_pub.pem']

  spec.extra_rdoc_files  = ['MANIFEST', 'README', 'CHANGES']

  spec.add_dependency('structured_warnings', '~> 0.3.0')
  spec.add_development_dependency('rake')

  spec.metadata = {
    'homepage_uri'      => 'https://github.com/djberg96/use',
    'bug_tracker_uri'   => 'https://github.com/djberg96/use/issues',
    'changelog_uri'     => 'https://github.com/djberg96/use/blob/master/CHANGES',
    'documentation_uri' => 'https://github.com/djberg96/use/wiki',
    'source_code_uri'   => 'https://github.com/djberg96/use',
    'wiki_uri'          => 'https://github.com/djberg96/use/wiki'
  }

  spec.description = <<-EOF
    The use library solves the multi-mixin problem by allowing you to
    selectively mixin specific methods from a module rather than mixing in
    all of them. In addition, you can alias methods on the fly as they are
    mixed in, effectively allowing you to change the name of the mixin method.
  EOF
end
