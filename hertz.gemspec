$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hertz/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hertz"
  s.version     = Hertz::VERSION
  s.authors     = ["Alessandro Desantis"]
  s.email       = ["desa.alessandro@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Hertz."
  s.description = "TODO: Description of Hertz."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.6"

  s.add_development_dependency "sqlite3"
end
