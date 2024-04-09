# frozen_string_literal: true

module RDockerize
  module Commands
    class Dockerize < Base
      def self.run(args)
        new(args)
      end

      # Create docker-compose file and Dockerfile
      def parse(args)
        RDockerize::Commands::Docker.run(args)
        RDockerize::Commands::Dco.run(args)
      end

      protected

      def banner
        <<~USAGE
          Usage:
              rdockerize dockerize
        USAGE
      end
    end
  end
end
