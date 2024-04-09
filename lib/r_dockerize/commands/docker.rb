# frozen_string_literal: true

module RDockerize
  module Commands
    class Docker < Base
      def self.run(args)
        new(args).run
      end

      def initialize(args)
        @user_temp = false
        @show = false
        @standard = false
        @port = nil
        super(args)
      end

      # rubocop:disable Metrics/MethodLength
      def parse(args)
        @rv = RUBY_VERSION

        parser = opt_parser do |opts|
          opts.banner = banner

          opts.on("-s", "--show", "# Show assembled dockerfile") do
            @show = true
          end

          opts.on("-u", "--user", "# Use saved user's template") do
            @user_temp = true
          end

          opts.on("-j", "--javascript=JAVASCRIPT", "# Choose JavaScript approach [options: #{JAVASCRIPT_PM.join(", ")}]") do |val|
            prepare_js_pm(val)
          end

          opts.on("-r", "--ruby=RUBY_VERSION", "# Choose version of ruby") do |val|
            @rv = val
          end

          opts.on("-d", "--database=DATABASE", "# Choose database [options: #{DATABASE.join(", ")}]") do |val|
            prepare_db(val)
          end

          opts.on("--standard", "# Standard template") do
            @standard = true
          end

          opts.on("-p", "--port=PORT", "# Set port") do |val|
            @port = val
          end
        end

        parser.parse!(args)
      end
      # rubocop:enable Metrics/MethodLength

      def run
        text = prepare_text
        return $stdout.puts text if @show

        File.open("Dockerfile", "w+") { |f| f.write(text) }
        
      end

      protected

      def banner
        <<~USAGE
          Usage:
              rdockerize docker [options]

          Options:
        USAGE
      end

      private

      def prepare_js_pm(option)
        unless JAVASCRIPT_PM.include?(option)
          raise Errors::JsNotFound, option: option, av_options: JAVASCRIPT_PM.join(" ")
        end

        @js_pm = option
      end

      def prepare_db(option)
        raise Errors::DbNotFound, option: option, av_options: DATABASE.join(" ") unless DATABASE.include?(option)

        @db = option
      end

      # Create final text for Dockerfile file
      def prepare_text
        return I18n.t("#{BASE_KEY}.docker.user_template") if @user_temp
        return I18n.t("#{BASE_KEY}.docker.standard", ruby_version: @rv) if @standard

        js_pm_text = I18n.t("#{BASE_KEY}.docker.js_pm.#{@js_pm}") if @js_pm
        db_text = I18n.t("#{BASE_KEY}.docker.db.#{@db}") if @db
        port_text = "EXPOSE #{@port}" if @port

        I18n.t("#{BASE_KEY}.docker.template",
               ruby_version: @rv, js_pm_option: js_pm_text, db_option: db_text, port: port_text)
      end
    end
  end
end
