# frozen_string_literal: true

require_relative "../spec_helper"

RSpec.describe "rdockerize docker" do
  context "without options" do
    it "create template of Dockerfile" do
      run_rdockerize("docker") do |_status, _output, _error|
        expect(File.exist?(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to be_truthy
      end
    end
  end

  context "with options" do
    context "create user template of Dockerfile" do
      it "-u" do
        run_rdockerize("docker -u") do |_status, _output, _error|
          expect(File.exist?(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to be_truthy
        end
      end

      it "--user" do
        run_rdockerize("docker --user") do |_status, _output, _error|
          expect(File.exist?(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to be_truthy
        end
      end
    end

    context "create standard template of Dockerfile" do
      it "--standard" do
        run_rdockerize("docker --standard") do |_status, _output, _error|
          expect(File.exist?(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to be_truthy
        end
      end
    end

    context "set ruby version for Dockerfile" do
      it "-r" do
        run_rdockerize("docker -r 3.1.2") do |_status, _output, _error|
          expect(File.exist?(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to be_truthy
          expect(File.read(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to include("3.1.2")
        end
      end

      it "--ruby" do
        run_rdockerize("docker --ruby=3.1.2") do |_status, _output, _error|
          expect(File.exist?(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to be_truthy
          expect(File.read(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to include("3.1.2")
        end
      end
    end
  end
end
