# frozen_string_literal: true

require "optionparser"

module RDockerize
  module Commands
    class Base
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
            $stdout.puts opts
          end
        end
      end
    end
  end
end
