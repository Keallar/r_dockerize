# frozen_string_literal: true

require "optionparser"

module RDockerize
  class CLI
    COMMANDS = {
      "dco" => "RDockerize::Commands::Dco",
      "compose" => "RDockerize::Commands::Dco",
      "docker-compose" => "RDockerize::Commands::Dco",
      "docker" => "RDockerize::Commands::Docker",
      "dockerize" => "RDockerize::Commands::Dockerize",
      "save" => "RDockerize::Commands::Save"
    }.freeze

    def initialize
      option_parser
      @print_help = false
    end

    def run(args = ARGV)
      command = parse_command(args)

      print_help? unless command

      args.delete(command)

      begin
        Object.const_get(COMMANDS[command]).run(args)
      rescue TypeError, KeyError
        raise Errors::CommandNotFound, command: command, av_commands: COMMANDS.keys.join(", ")
      rescue StandardError => e
        if DEBUG
          $stdout.puts e.message
          $stdout.puts e.backtrace.join("\n")
        end
      end
    end

    private

    def option_parser
      @option_parser ||= OptionParser.new do |opts|
        opts.banner = banner

        opts.on("-v", "--version", "# Print the version number") do
          $stdout.puts VERSION
          exit 0
        end

        opts.on("-h", "--help", "# Print help") do
          @print_help = true
        end
      end
    end

    def print_help?
      $stdout.puts option_parser.help
      exit 0
    end

    def parse_command(args)
      c_args = args.clone
      unknown_args = []
      begin
        ordered_args = option_parser.order(c_args)
        if ordered_args.empty?
          option_parser.parse!(c_args)
          return
        end
        command = c_args.shift
      rescue OptionParser::InvalidOption => e
        unknown_args += e.args
        c_args -= unknown_args
        retry
      end
      command
    end

    def banner
      <<~USAGE
        Usage:
            rdockerize <command> [options]

        Commands:
            dockerize                        Create both files (Dockerfile and docker-compose.yml)
            dco (or compose, docker-compose) Create docker-compose.yml file
            docker                           Create Dockerfile
            save                             Save user template for Dockerfile or docker-compose.yml

        Options:
      USAGE
    end
  end
end
