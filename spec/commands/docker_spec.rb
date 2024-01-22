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
          expect(File.read(File.join(File.expand_path("../..", __dir__),
                                     "Dockerfile"))).to include("# Standard Dockerfile")
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

    context "show assembled Dockerfile" do
      it "-s" do
        run_rdockerize("docker -s") do |_status, output, _error|
          expect(output).not_to be_empty
          expect(output).to include("# Template Dockerfile")
        end
      end

      it "--show" do
        run_rdockerize("docker --show") do |_status, output, _error|
          expect(output).not_to be_empty
          expect(output).to include("# Template Dockerfile")
        end
      end
    end

    context "set js package manager" do
      context "-j" do
        it "npm" do
          run_rdockerize("docker -j npm") do |_status, _output, _error|
            expect(File.exist?(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to be_truthy
            expect(File.read(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to include("nodejs")
          end
        end

        it "yarn" do
          run_rdockerize("docker -j yarn") do |_status, _output, _error|
            expect(File.exist?(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to be_truthy
            expect(File.read(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to include("yarn")
          end
        end

        context "with error" do
          it "Non available js option" do
            run_rdockerize("docker -j n", should_fail: true) do |_status, output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to be_falsey
              expect(output).to include("Non available js option")
            end
          end
        end
      end

      context "--javascript" do
        it "npm" do
          run_rdockerize("docker --javascript=npm") do |_status, _output, _error|
            expect(File.exist?(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to be_truthy
            expect(File.read(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to include("nodejs")
          end
        end

        it "yarn" do
          run_rdockerize("docker --javascript=yarn") do |_status, _output, _error|
            expect(File.exist?(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to be_truthy
            expect(File.read(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to include("yarn")
          end
        end

        context "with error" do
          it "Non available js option" do
            run_rdockerize("docker --javascript=n", should_fail: true) do |_status, output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to be_falsey
              expect(output).to include("Non available js option")
            end
          end
        end
      end
    end

    context "set database" do
      context "-d" do
        it "sqlite" do
          run_rdockerize("docker -d sqlite") do |_status, _output, _error|
            expect(File.exist?(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to be_truthy
            expect(File.read(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to include("sqlite")
          end
        end

        context "with error" do
          it "Non available db option" do
            run_rdockerize("docker -d sqlit", should_fail: true) do |_status, output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to be_falsey
              expect(output).to include("Non available db option")
            end
          end
        end
      end

      context "--database" do
        it "sqlite" do
          run_rdockerize("docker --database=sqlite") do |_status, _output, _error|
            expect(File.exist?(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to be_truthy
            expect(File.read(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to include("sqlite")
          end
        end

        context "with error" do
          it "Non available db option" do
            run_rdockerize("docker --database=sqlit", should_fail: true) do |_status, output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "Dockerfile"))).to be_falsey
              expect(output).to include("Non available db option")
            end
          end
        end
      end
    end
  end
end
