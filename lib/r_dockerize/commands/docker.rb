# frozen_string_literal: true

module RDockerize
  module Commands
    class Docker < Base
      attr_reader :db, :js_np, :rv

      def self.run(args)
        new(args).run
      end

      def parse(args)
        @rv = RUBY_VERSION

        parser = opt_parser do |opts|
          opts.banner = banner

          opts.on("-s", "--save=FILE_PATH") do |val|
            save_template(val)
            $stdout.puts val
          end

          opts.on("-j", "--javascript=JAVASCRIPT") do |val|
            prepare_js_np(val)
            $stdout.puts @js
          end

          opts.on("-r", "--ruby_version=RUBY_VERSION") do |val|
            @rv = val
            $stdout.puts @rv
          end

          opts.on("-d", "--database=DATABASE") do |val|
            prepare_db(val)
            $stdout.puts @db
          end
        end

        parser.parse!(args)
      end

      def run
        text = prepare_text
        File.open("Dockerfile", "w+") { |f| f.write(text) }
      end

      protected

      def banner
        <<~USAGE
          Usage:
            rdockerize docker [options]

          Options:
            -j [--javascript=JAVASCRIPT]
            -r [--ruby_version=RUBY_VERSION]
            -d [--database=DATABASE]
            -s [--save=FILE]
        USAGE
      end

      private

      def prepare_js_np(option)
        unless JAVASCRIPT_PM.include?(option)
          raise RDockerize::Errors::JsNotFound, option: option,
                                                av_options: JAVASCRIPT_PM.join(" ")
        end

        @js_np = option
      end

      def prepare_db(option)
        unless DATABASE.include?(option)
          raise RDockerize::Errors::DbNotFound, option: option,
                                                av_options: DATABASE.join(" ")
        end

        @db = option
      end

      def prepare_text
        return I18n.t("#{BASE_KEY}.docker.standard", ruby_version: @rv) unless @db && @js_np

        js_np_text = I18n.t("#{BASE_KEY}.docker.js_np.#{@js_np}")
        db_text = I18n.t("#{BASE_KEY}.docker.db.#{@db}")

        I18n.t("#{BASE_KEY}.docker.template",
               ruby_version: @rv, js_np_option: js_np_text, db_option: db_text)
      end

      def save_template(path)
        user_data = File.read(File.expand_path(path))
        i18n_path = I18n.load_path.last
        yaml_hash = YAML.load(File.read(i18n_path), symbolize_names: true)
        yaml_hash[:en][:r_dockerize][:docker][:user_template] = user_data
        File.write(i18n_path, yaml_hash.to_yaml)
      end

      # Validate filename of template
      def check_template

      end
    end
  end
end
