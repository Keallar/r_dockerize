# frozen_string_literal: true

require_relative "lib/r_dockerize/config"

Gem::Specification.new do |spec|
  spec.name = "r_dockerize"
  spec.version = RDockerize::VERSION
  spec.authors = ["Keallar"]
  spec.email = ["zlysanskiy@gmail.com"]

  spec.summary = "CLI app for creating ruby and rails Dockerfile and docker-compose.yml."
  spec.description = "CLI app for creating ruby and rails Dockerfile and docker-compose.yml"
  spec.homepage = "https://github.com/Keallar/r_dockerize"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = [
    Dir.glob("{lib,bin}/**/*"),
    "README.md",
    "CHANGELOG.md",
    "LICENSE.txt"
  ]
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "i18n", "~> 1.14.1"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
