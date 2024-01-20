# frozen_string_literal: true

require_relative "../spec_helper"
require_relative "../support/command_helper"
require "fileutils"

RSpec.describe "rdockerize docker" do
  let!(:cmd) { CommandHelper.new }
  let!(:root) { File.expand_path("../..", __dir__) }

  after do
    FileUtils.rm(File.join(root, "Dockerfile"))
  end

  it "create standard Dockerfile" do
    cmd.run_rdockerize("docker") do |_status, _output, _error|
      expect(File.exist?(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to be_truthy
    end
  end
end
