# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "spooky/version"

Gem::Specification.new do |spec|
  spec.name          = "spooky"
  spec.version       = Spooky::VERSION
  spec.authors       = ["Ritchie Blair"]
  spec.email         = ["ritchie@infinityrobot.com"]

  spec.summary       = "A simple Ruby wrapper for the Ghost blog public API."
  spec.description   = "Access the Ghost blog public API via Ruby."
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  file_match = %r{^(test|spec|features)/}
  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(file_match) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.13"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "dotenv", "~> 2.1"
end
