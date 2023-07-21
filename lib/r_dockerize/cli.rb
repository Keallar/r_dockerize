# frozen_string_literal: true

require "optionparser"

module RDockerize
  class CLI
    COMMANDS = {
      "dco" => "RDockerize::Commands::Dco",
      "compose" => "RDockerize::Commands::Dco",
      "docker-compose" => "RDockerize::Commands::Dco",
      "docker" => "RDockerize::Commands::Docker",
      "dockerize" => "RDockerize::Commands::Dockerize"
    }.freeze

    def initialize
      option_parser
      @print_help = false
    end

    def run(args = ARGV)
      command = parse_command(args)

      puts "COMMAND: #{command}"
      print_version?(args) unless command

      begin
        Object.const_get(COMMANDS[command]).run(args)
      rescue TypeError, KeyError
        raise RDockerize::Errors::CommandNotFound, command: command, av_commands: COMMANDS.keys.join(", ")
      rescue StandardError => e
        $stdout.puts e.message
        $stdout.puts e.backtrace.join("\n") if RDockerize::DEBUG
      end
    end

    private

    def option_parser
      @option_parser ||= OptionParser.new do |opts|
        opts.banner = "Usage:\n   rdockerize <command> [options] \nCommands:\n   (dco compose docker-compose) docker dockerize"

        opts.on("-v", "--version", "# Print the version number, then exit") do
          $stdout.puts RDockerize::VERSION
          exit 0
        end

        opts.on("-h", "--help", "# Print help") do
          $stdout.puts opts
          exit 0
        end
      end
    end

    def print_version?(args)
      c_args = args.clone
      begin
        option_parser.parse!(c_args)
      rescue OptionParser::InvalidOption => e
        $stdout.puts e.message
      end
    end

    def parse_command(args)
      c_args = args.clone
      unknown_args = []
      begin
        command, = option_parser.permute(c_args)
      rescue OptionParser::InvalidOption => e
        unknown_args += e.args
        c_args -= unknown_args
        retry
      end
      command
    end
  end
end
