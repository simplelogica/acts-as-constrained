$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_constrained/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acts-as-constrained"
  s.version     = ActsAsConstrained::VERSION
  s.authors     = ["David J. Brenes"]
  s.email       = ["davidjbrenes@gmail.com"]
  s.homepage    = "https://github.com/simplelogica/acts_as_constrained"
  s.summary     = "Rails engine for defining how a model will be filtered and constrained"
  s.description = "Rails engine for defining how a model will be filtered and constrained"
  s.license     = "GPL"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0", "< 4.3"

  s.add_development_dependency "sqlite3"

end
