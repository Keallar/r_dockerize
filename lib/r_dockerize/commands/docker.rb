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
          opts.banner = "Usage:\n   rdockerize docker [options]"

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

      private

      # rubocop disable:Style/IfUnlessModifier
      def prepare_js_np(option)
        raise RDockerize::Errors::JsNotFound, option: option, av_options: JAVASCRIPT_PM.join(" ") unless JAVASCRIPT_PM.include?(option)

        @js_np = option
      end

      def prepare_db(option)
        raise RDockerize::Errors::DbNotFound, option: option, av_options: DATABASE.join(" ") unless DATABASE.include?(option)

        @db = option
      end
      # rubocop enable:Style/IfUnlessModifier

      def prepare_text
        return I18n.t("#{BASE_KEY}.docker.standard", ruby_version: @rv) unless @db && @js_np

        js_np_text = I18n.t("#{BASE_KEY}.docker.js_np.#{@js_np}")
        db_text = I18n.t("#{BASE_KEY}.docker.db.#{@db}")

        I18n.t("#{BASE_KEY}.docker.template",
               ruby_version: @rv, js_np_option: js_np_text, db_option: db_text)
      end
    end
  end
end
