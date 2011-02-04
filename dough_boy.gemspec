# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dough_boy/version"

Gem::Specification.new do |s|
  s.name        = "dough_boy"
  s.version     = DoughBoy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Joshua Schairbaum"]
  s.email       = ["joshua.schairbaum@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Easily run command-line programs. This }
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "dough_boy"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('rspec')
end
