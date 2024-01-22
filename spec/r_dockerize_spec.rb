# frozen_string_literal: true

RSpec.describe RDockerize do
  it "has a version number" do
    expect(RDockerize::VERSION).not_to be nil
  end

  context "rdockerize" do
    it "without options" do
      run_rdockerize_without_subcommand do |_status, output, _error|
        expect(output).not_to be_empty
      end
    end

    context "with options" do
      it "-h" do
        run_rdockerize("-h") do |_status, output, _error|
          expect(output).not_to be_empty
          expect(output).to include("Commands")
          expect(output).to include("Options")
        end
      end

      it "--help" do
        run_rdockerize("--help") do |_status, output, _error|
          expect(output).not_to be_empty
          expect(output).to include("Commands")
          expect(output).to include("Options")
        end
      end

      it "-v" do
        run_rdockerize("-v") do |_status, output, _error|
          expect(output).not_to be_empty
          expect(output).to include(RDockerize::VERSION)
        end
      end

      it "--version" do
        run_rdockerize("--version") do |_status, output, _error|
          expect(output).not_to be_empty
          expect(output).to include(RDockerize::VERSION)
        end
      end
    end
  end
end
