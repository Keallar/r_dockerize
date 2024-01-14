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

          opts.on("-d", "--dockerfile=DOCKERFILE") do |val|
            save_template(val)
            $stdout.puts val
          end

          opts.on("-c", "--compose=COMPOSEFILE") do |val|
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
            -d [--dockerfile]
            -c [--compose]
        USAGE
      end

      private

      def save_template(path)
        user_data = File.read(File.expand_path(path))
        i18n_path = I18n.load_path.last
        yaml_hash = YAML.load(File.read(i18n_path), symbolize_names: true)
        yaml_hash[:en][:r_dockerize][:docker][:user_template] = user_data
        File.write(i18n_path, yaml_hash.to_yaml)
      end

      # Validate filename of template
      def check_template; end
    end
  end
end
