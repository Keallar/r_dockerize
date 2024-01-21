# frozen_string_literal: true

require "r_dockerize"
require "fileutils"
require_relative "support/command_helper"

RSpec.configure do |config|
  config.include CommandHelper

  config.example_status_persistence_file_path = ".rspec_status"

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.after(:each) do
    root = File.expand_path("..", __dir__)
    dockerfile_path = File.join(root, "Dockerfile")
    dco_path = File.join(root, "docker-compose.yml")
    FileUtils.rm(dockerfile_path) if File.exist?(dockerfile_path)
    FileUtils.rm(dco_path) if File.exist?(dco_path)
  end
end
