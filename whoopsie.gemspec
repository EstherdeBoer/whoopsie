$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "whoopsie/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "oxos-whoopsie"
  s.version     = Whoopsie::VERSION
  s.authors     = ["Wojtek Kruszewski"]
  s.email       = ["wojtek@oxos.pl"]
  s.homepage    = "https://github.com/OXOS/whoopsie"
  s.summary     = "Server+client error notifications for OXOS apps"
  s.description = "ExceptionNotification for email notifications + TraceKit for catching client-side errors"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"
  s.add_dependency "exception_notification", "~> 4.0.1"
end
