# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack/heroku_meta/version"

Gem::Specification.new do |s|
  s.name        = "rack_heroku_meta"
  s.version     = Rack::HerokuMeta::VERSION
  s.authors     = ["Brendon Murphy"]
  s.email       = ["xternal1+github@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Rack middleware for checking the process commit hash on Heroku}
  s.description = s.summary

  s.rubyforge_project = "rack_heroku_meta"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency "rack"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "json"
end
