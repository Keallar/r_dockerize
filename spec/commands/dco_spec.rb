# frozen_string_literal: true

require_relative "../spec_helper"

RSpec.describe "rdockerize dco / compose / docker-compose" do
  context "without options" do
    it "with dco subcommand" do
      run_rdockerize("dco") do |_status, _output, _error|
        expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
      end
    end

    it "with compose subcommand" do
      run_rdockerize("compose") do |_status, _output, _error|
        expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
      end
    end

    it "with docker-compose subcommand" do
      run_rdockerize("docker-compose") do |_status, _output, _error|
        expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
      end
    end
  end
end
