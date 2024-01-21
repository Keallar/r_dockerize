# frozen_string_literal: true

require_relative "lib/r_dockerize/config"

Gem::Specification.new do |spec|
  spec.name = "r_dockerize"
  spec.version = RDockerize::VERSION
  spec.authors = ["Keallar"]
  spec.email = ["zlysanskiy@gmail.com"]

  spec.summary = "Write a short summary, because RubyGems requires one."
  spec.description = "Write a longer description or delete this line."
  spec.homepage = "https://github.com/Keallar/r_dockerize"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = [
    Dir.glob("bin/*"),
    Dir.glob("lib/**/*"),
    "README.md",
    "CHANGELOG.md",
    "LICENSE.txt"
  ]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "i18n", "~> 1.14.1"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
