# frozen_string_literal: true

require_relative "../spec_helper"

RSpec.describe "rdockerize dco / compose / docker-compose" do
  context "without options" do
    it "with dco subcommand" do
      run_rdockerize("dco") do |_status, _output, _error|
        expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
        expect(File.read(File.join(File.expand_path("../..", __dir__),
                                   "docker-compose.yml"))).to include("# Standard template")
      end
    end

    it "with compose subcommand" do
      run_rdockerize("compose") do |_status, _output, _error|
        expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
        expect(File.read(File.join(File.expand_path("../..", __dir__),
                                   "docker-compose.yml"))).to include("# Standard template")
      end
    end

    it "with docker-compose subcommand" do
      run_rdockerize("docker-compose") do |_status, _output, _error|
        expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
        expect(File.read(File.join(File.expand_path("../..", __dir__),
                                   "docker-compose.yml"))).to include("# Standard template")
      end
    end
  end

  context "with options" do
    context "with dco subcommand" do
      context "when create user template of docker-compose.yml" do
        it "-u" do
          run_rdockerize("dco -u") do |_status, _output, _error|
            expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
          end
        end

        it "--user" do
          run_rdockerize("dco --user") do |_status, _output, _error|
            expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
          end
        end
      end

      context "when show assembled docker-compose.yml" do
        it "-s" do
          run_rdockerize("dco -s") do |_status, output, _error|
            expect(output).not_to be_empty
            expect(output).to include("# Standard template")
          end
        end

        it "--show" do
          run_rdockerize("dco --show") do |_status, output, _error|
            expect(output).not_to be_empty
            expect(output).to include("# Standard template")
          end
        end
      end

      context "with set database" do
        context "-d" do
          it "sqlite" do
            run_rdockerize("dco -d sqlite") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("sqlite")
            end
          end

          it "postgresql" do
            run_rdockerize("dco -d postgresql") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("postgresql")
            end
          end

          it "mongodb" do
            run_rdockerize("dco -d mongodb") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("mongodb")
            end
          end

          it "mysql" do
            run_rdockerize("dco -d mysql") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to include("mysql")
            end
          end

          context "with error" do
            it "Non available db option" do
              run_rdockerize("dco -d sqlit", should_fail: true) do |_status, _output, error|
                expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_falsey
                expect(error).to include("Non available db option")
              end
            end
          end
        end

        context "--database" do
          it "sqlite" do
            run_rdockerize("dco --database=sqlite") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("sqlite")
            end
          end

          it "postgresql" do
            run_rdockerize("dco --database=postgresql") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("postgresql")
            end
          end

          it "mongodb" do
            run_rdockerize("dco --database=mongodb") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("mongodb")
            end
          end

          it "mysql" do
            run_rdockerize("dco --database=mysql") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to include("mysql")
            end
          end

          context "with error" do
            it "Non available db option" do
              run_rdockerize("dco --database=sqlit", should_fail: true) do |_status, _output, error|
                expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_falsey
                expect(error).to include("Non available db option")
              end
            end
          end
        end
      end

      context "set subservice" do
        context "-b" do
          it "redis" do
            run_rdockerize("dco -b redis") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to include("redis")
            end
          end

          it "rabbitmq" do
            run_rdockerize("dco -b rabbitmq") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("rabbitmq")
            end
          end

          it "sidekiq" do
            run_rdockerize("dco -b sidekiq") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("sidekiq")
            end
          end

          context "with error" do
            it "Non available subservices option" do
              run_rdockerize("dco -b test", should_fail: true) do |_status, _output, error|
                expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_falsey
                expect(error).to include("Non available subservice option")
              end
            end
          end
        end

        context "--subservice" do
          it "redis" do
            run_rdockerize("dco --subservice=redis") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to include("redis")
            end
          end

          it "rabbitmq" do
            run_rdockerize("dco --subservice=rabbitmq") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("rabbitmq")
            end
          end

          it "sidekiq" do
            run_rdockerize("dco --subservice=sidekiq") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("sidekiq")
            end
          end

          context "with error" do
            it "Non available subservices option" do
              run_rdockerize("dco --subservice=test", should_fail: true) do |_status, _output, error|
                expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_falsey
                expect(error).to include("Non available subservice option")
              end
            end
          end
        end
      end
    end

    context "with compose subcommand" do
      context "create user template of docker-compose.yml" do
        it "-u" do
          run_rdockerize("compose -u") do |_status, _output, _error|
            expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
          end
        end

        it "--user" do
          run_rdockerize("compose --user") do |_status, _output, _error|
            expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
          end
        end
      end

      context "show assembled docker-compose.yml" do
        it "-s" do
          run_rdockerize("compose -s") do |_status, output, _error|
            expect(output).not_to be_empty
            expect(output).to include("# Standard template")
          end
        end

        it "--show" do
          run_rdockerize("compose --show") do |_status, output, _error|
            expect(output).not_to be_empty
            expect(output).to include("# Standard template")
          end
        end
      end

      context "set database" do
        context "-d" do
          it "sqlite" do
            run_rdockerize("compose -d sqlite") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("sqlite")
            end
          end

          it "postgresql" do
            run_rdockerize("compose -d postgresql") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("postgresql")
            end
          end

          it "mongodb" do
            run_rdockerize("compose -d mongodb") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("mongodb")
            end
          end

          it "mysql" do
            run_rdockerize("compose -d mysql") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to include("mysql")
            end
          end

          context "with error" do
            it "Non available db option" do
              run_rdockerize("compose -d sqlit", should_fail: true) do |_status, _output, error|
                expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_falsey
                expect(error).to include("Non available db option")
              end
            end
          end
        end

        context "--database" do
          it "sqlite" do
            run_rdockerize("compose --database=sqlite") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("sqlite")
            end
          end

          it "postgresql" do
            run_rdockerize("compose --database=postgresql") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("postgresql")
            end
          end

          it "mongodb" do
            run_rdockerize("compose --database=mongodb") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("mongodb")
            end
          end

          it "mysql" do
            run_rdockerize("compose --database=mysql") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to include("mysql")
            end
          end

          context "with error" do
            it "Non available db option" do
              run_rdockerize("compose --database=sqlit", should_fail: true) do |_status, _output, error|
                expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_falsey
                expect(error).to include("Non available db option")
              end
            end
          end
        end
      end

      context "set subservice" do
        context "-b" do
          it "redis" do
            run_rdockerize("compose -b redis") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to include("redis")
            end
          end

          it "rabbitmq" do
            run_rdockerize("compose -b rabbitmq") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("rabbitmq")
            end
          end

          it "sidekiq" do
            run_rdockerize("compose -b sidekiq") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("sidekiq")
            end
          end

          context "with error" do
            it "Non available subservices option" do
              run_rdockerize("compose -b test", should_fail: true) do |_status, _output, error|
                expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_falsey
                expect(error).to include("Non available subservice option")
              end
            end
          end
        end

        context "--subservice" do
          it "redis" do
            run_rdockerize("compose --subservice=redis") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to include("redis")
            end
          end

          it "rabbitmq" do
            run_rdockerize("compose --subservice=rabbitmq") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("rabbitmq")
            end
          end

          it "sidekiq" do
            run_rdockerize("compose --subservice=sidekiq") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("sidekiq")
            end
          end

          context "with error" do
            it "Non available subservices option" do
              run_rdockerize("compose --subservice=test", should_fail: true) do |_status, _output, error|
                expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_falsey
                expect(error).to include("Non available subservice option")
              end
            end
          end
        end
      end
    end

    context "with docker-compose subcommand" do
      context "create user template of docker-compose.yml" do
        it "-u" do
          run_rdockerize("docker-compose -u") do |_status, _output, _error|
            expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
          end
        end

        it "--user" do
          run_rdockerize("docker-compose --user") do |_status, _output, _error|
            expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
          end
        end
      end

      context "show assembled docker-compose.yml" do
        it "-s" do
          run_rdockerize("docker-compose -s") do |_status, output, _error|
            expect(output).not_to be_empty
            expect(output).to include("# Standard template")
          end
        end

        it "--show" do
          run_rdockerize("compose --show") do |_status, output, _error|
            expect(output).not_to be_empty
            expect(output).to include("# Standard template")
          end
        end
      end

      context "set database" do
        context "-d" do
          it "sqlite" do
            run_rdockerize("docker-compose -d sqlite") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("sqlite")
            end
          end

          it "postgresql" do
            run_rdockerize("docker-compose -d postgresql") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("postgresql")
            end
          end

          it "mongodb" do
            run_rdockerize("docker-compose -d mongodb") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("mongodb")
            end
          end

          it "mysql" do
            run_rdockerize("docker-compose -d mysql") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to include("mysql")
            end
          end

          context "with error" do
            it "Non available db option" do
              run_rdockerize("docker-compose -d sqlit", should_fail: true) do |_status, _output, error|
                expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_falsey
                expect(error).to include("Non available db option")
              end
            end
          end
        end

        context "--database" do
          it "sqlite" do
            run_rdockerize("docker-compose --database=sqlite") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("sqlite")
            end
          end

          it "postgresql" do
            run_rdockerize("docker-compose --database=postgresql") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("postgresql")
            end
          end

          it "mongodb" do
            run_rdockerize("docker-compose --database=mongodb") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("mongodb")
            end
          end

          it "mysql" do
            run_rdockerize("docker-compose --database=mysql") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to include("mysql")
            end
          end

          context "with error" do
            it "Non available db option" do
              run_rdockerize("docker-compose --database=sqlit", should_fail: true) do |_status, _output, error|
                expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_falsey
                expect(error).to include("Non available db option")
              end
            end
          end
        end
      end

      context "set subservice" do
        context "-b" do
          it "redis" do
            run_rdockerize("docker-compose -b redis") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to include("redis")
            end
          end

          it "rabbitmq" do
            run_rdockerize("docker-compose -b rabbitmq") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("rabbitmq")
            end
          end

          it "sidekiq" do
            run_rdockerize("docker-compose -b sidekiq") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("sidekiq")
            end
          end

          context "with error" do
            it "Non available subservices option" do
              run_rdockerize("docker-compose -b test", should_fail: true) do |_status, _output, error|
                expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_falsey
                expect(error).to include("Non available subservice option")
              end
            end
          end
        end

        context "--subservice" do
          it "redis" do
            run_rdockerize("docker-compose --subservice=redis") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to include("redis")
            end
          end

          it "rabbitmq" do
            run_rdockerize("docker-compose --subservice=rabbitmq") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("rabbitmq")
            end
          end

          it "sidekiq" do
            run_rdockerize("docker-compose --subservice=sidekiq") do |_status, _output, _error|
              expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_truthy
              expect(File.read(File.join(File.expand_path("../..", __dir__),
                                         "docker-compose.yml"))).to include("sidekiq")
            end
          end

          context "with error" do
            it "Non available subservices option" do
              run_rdockerize("docker-compose --subservice=test", should_fail: true) do |_status, _output, error|
                expect(File.exist?(File.join(File.expand_path("../..", __dir__), "docker-compose.yml"))).to be_falsey
                expect(error).to include("Non available subservice option")
              end
            end
          end
        end
      end
    end
  end
end
