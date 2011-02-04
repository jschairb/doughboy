# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "doughboy/version"

Gem::Specification.new do |s|
  s.name        = "doughboy"
  s.version     = Doughboy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Joshua Schairbaum"]
  s.email       = ["joshua.schairbaum@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Easily run command-line programs. This }
  s.description = %q{Doughboy is a Ruby library that strives to enable developers to easily make subprocessed shell calls.}

  s.rubyforge_project = "doughboy"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('open4', '~>1.0.1')
  s.add_development_dependency('rspec', "~>2.4.0")
end
