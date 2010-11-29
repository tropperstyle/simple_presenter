# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_presenter/version"

Gem::Specification.new do |s|
  s.name        = "simple_presenter"
  s.version     = SimplePresenter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = "Jonathan Tropper"
  s.email       = "tropperstyle@gmail.com"
  s.homepage    = ""
  s.summary     = "A Ruby Presentation Library"
  s.description = "Simple way to organize presentation logic within the model"

  s.rubyforge_project = "simple_presenter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
