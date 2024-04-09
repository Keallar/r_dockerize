# frozen_string_literal: true

require "optionparser"

module RDockerize
  module Commands
    # Abstract class for all commands
    class Base
      # Base key for access i18n templates
      BASE_KEY = "r_dockerize"

      def self.run(args)
        new(args).run
      end

      def initialize(args)
        parse(args)
      end

      def run
        raise NotImplementedError
      end

      def parse(args)
        raise NotImplementedError
      end

      protected

      def opt_parser
        OptionParser.new do |opts|
          yield opts if block_given?

          opts.on("-h", "--help", "# Print help for command") do
            $stdout.puts opts.help
            exit 0
          end
        end
      end

      def banner
        raise NotImplementedError
      end
    end
  end
end
