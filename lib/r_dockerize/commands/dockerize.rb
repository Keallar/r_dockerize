# frozen_string_literal: true

module RDockerize
  module Commands
    class Dockerize < Base
      def self.run(args)
        new(args)
      end

      def run
        nil
      end

      def parse(args)
        RDockerize::Commands::Dco.run(args)
        RDockerize::Commands::Docker.run(args)
      end
    end
  end
end
