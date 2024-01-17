# frozen_string_literal: true

module RDockerize
  module Commands
    class Save < Base
      def self.run(args)
        new(args).run
      end

      def parse(args)
        parser = opt_parser do |opts|
          opts.banner = banner

          opts.on("-d", "--dockerfile=DOCKERFILE_PATH", "# Path to Dockerfile (default)") do |val|
            docker_file?(val)
            save_template(val, :docker)
            $stdout.puts val
          end

          opts.on("-c", "--compose=COMPOSEFILE_PATH", "# Path to docker-compose file") do |val|
            docker_file?(val)
            save_template(val, :dco)
            $stdout.puts val
          end
        end

        parser.parse!(args)
      end

      def run
        $stdout.puts "Template saved!"
      end

      protected

      def banner
        <<~USAGE
          Usage:
              rdockerize save [options]

          Options:
        USAGE
      end

      private

      def save_template(path, type)
        user_data = File.read(File.expand_path(path))
        i18n_path = I18n.load_path.last
        yaml_hash = YAML.load(File.read(i18n_path), symbolize_names: true)
        yaml_hash[:en][:r_dockerize][type][:user_template] = user_data
        File.write(i18n_path, yaml_hash.to_yaml)
      end

      # Validate filename of template
      def docker_file?(path)
        raise StandardError unless File.basename(path).downcase.include?("docker")
      end
    end
  end
end
