$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "simple_active_storage/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "simple_active_storage"
  s.version     = SimpleActiveStorage::VERSION
  s.authors     = ["aotianlong"]
  s.email       = ["aotianlong@gmail.com"]
  s.homepage    = "http://www.github.com/aotianlong"
  s.summary     = "add shortcut variant support for active storage"
  s.description = "improve active storage"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"

  s.add_development_dependency "sqlite3"
end
