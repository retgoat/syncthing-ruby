# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'syncthing/version'

Gem::Specification.new do |spec|
  spec.name          = "syncthing"
  spec.version       = Syncthing::VERSION
  spec.authors       = ["Roman Sotnikov"]
  spec.email         = ["roman.sotnikov@gmail.com"]
  spec.summary       = %q{Syncthing REST API bundings.}
  spec.description   = %q{Gem to access syncthing REST API in ruby and ruby on rails applications.}
  spec.homepage      = "https://github.com/retgoat/syncthing-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  s.add_development_dependency 'webmock'
  
end
