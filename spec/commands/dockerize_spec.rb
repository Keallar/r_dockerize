# frozen_string_literal: true

require_relative "../spec_helper"

RSpec.describe "rdockerize dockerize" do
  it "create standard docker-compose.yml and Dockerfile" do
    run_rdockerize("dockerize") do |_status, _output, _error|
      expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
      expect(File.exist?(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to be_truthy
    end
  end
end
