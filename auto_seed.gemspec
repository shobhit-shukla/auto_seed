# frozen_string_literal: true

require_relative "lib/auto_seed/version"

Gem::Specification.new do |spec|
  spec.name = "auto_seed"
  spec.version = AutoSeed::VERSION
  spec.authors = ["Shobhit Shukla"]
  spec.email = ["shobits001@outlook.com"]

  spec.summary       = "A gem to generate seed files from model schema comments"
  spec.description   = "AutoSeed uses model schema comments to automatically generate seed files for Rails applications."
  spec.homepage = "https://github.com/shobhit-shukla/auto_seed"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/shobhit-shukla/auto_seed"
  spec.metadata["changelog_uri"] = "https://github.com/shobhit-shukla/auto_seed"

  spec.files = Dir["{app,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "sqlite3", "~> 1.4"
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
end
