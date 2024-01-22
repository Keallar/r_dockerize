# frozen_string_literal: true

require_relative "../spec_helper"

RSpec.describe "rdockerize save" do
  it "without options" do
    run_rdockerize("save", should_fail: true) do |_status, output, _error|
      puts "output: #{output}"
      expect(output).not_to be_empty
      expect(output).to include("invalid option")
    end
  end

  context "with options" do
    context "Dockerfile" do
      before { run_rdockerize("docker") }

      context "-d" do
        it "with successfully validate" do
          run_rdockerize("save -d './Dockerfile'") do |_status, output, _error|
            expect(output).not_to be_empty
          end
        end

        it "with failure validate" do
          run_rdockerize("save -d './Doc'", should_fail: true) do |_status, output, _error|
            expect(output).not_to be_empty
          end
        end
      end

      context "--dockerfile" do
        it "with successfully validate" do
          run_rdockerize("save --dockerfile='./Dockerfile'") do |_status, output, _error|
            expect(output).not_to be_empty
          end
        end

        it "with failure validate" do
          run_rdockerize("save -d './mompose.yml'", should_fail: true) do |_status, output, _error|
            expect(output).not_to be_empty
          end
        end
      end
    end

    context "docker-compose" do
      before { run_rdockerize("dco") }

      it "-c" do
        run_rdockerize("save -c './docker-compose.yml'") do |_status, output, _error|
          expect(output).not_to be_empty
        end
      end

      it "--compose" do
        run_rdockerize("save --dockerfile='./docker-compose.yml'") do |_status, output, _error|
          expect(output).not_to be_empty
        end
      end
    end
  end
end
