# frozen_string_literal: true

module RDockerize
  module Commands
    # rubocop disable:Style/IfUnlessModifier
    class Dco < Base
      attr_reader :db, :js, :subservices, :volumes

      def self.run(args)
        new(args).run
      end

      def parse(args)
        @db = "sqlite"

        parser = opt_parser do |opts|
          opts.banner = banner

          opts.on("-j", "--javascript=JAVASCRIPT") do |val|
            prepare_js(val)
            $stdout.puts @js
          end

          opts.on("-d", "--database=DATABASE") do |val|
            prepare_db(val)
            $stdout.puts @db
          end

          opts.on("-s", "--subservices=SUBSERVICES") do |val|
            prepare_subservices(val)
            $stdout.puts @subservices
          end
        end

        parser.parse!(args)
      end

      def run
        text = prepare_text
        File.open("docker-compose.yml", "w+") { |f| f.write(text) }
      end

      protected

      def banner
        <<~USAGE
          Usage:
            rdockerize dco [options]
            rdockerize compose [options]
            rdockerize docker-compose [options]

          Options:
            -j [--javascript=JAVASCRIPT]
            -r [--ruby_version=RUBY_VERSION]
            -s [--subservices=SUBSERVICES]
        USAGE
      end

      private

      def prepare_js(option)
        unless JAVASCRIPT.include?(option)
          raise RDockerize::Errors::JsNotFound, option: option,
                                                av_options: RDockerize::JAVASCRIPT.join(" ")
        end

        @js = option
      end

      def prepare_db(option)
        unless DATABASE.include?(option)
          raise RDockerize::Errors::DbNotFound, option: option,
                                                av_options: DATABASE.join(" ")
        end

        @db = option
      end

      def prepare_subservices(option)
        unless SUBSERVICES.include?(option)
          raise RDockerize::Errors::SubserviceNotFound, option: option,
                                                        av_options: SUBSERVICES.join(" ")
        end

        @subservices = option
      end

      def prepare_text
        js_text = I18n.t("#{BASE_KEY}.dco.js.#{@js}") if js_text
        db_text = I18n.t("#{BASE_KEY}.dco.db.#{@db}")
        subservice_text = if @subservices
                            @subservices.each_with_object("") do |service, str|
                              str << I18n.t("#{BASE_KEY}.dco.subservices.#{service}")
                            end
                          else
                            ""
                          end

        volumes_text = "volumes:\n  #{@db}:"

        I18n.t(
          "#{BASE_KEY}.dco.template",
          js_option: js_text, db_option: db_text, subservices_option: subservice_text, volumes_option: volumes_text
        )
      end
    end
    # rubocop enable:Style/IfUnlessModifier
  end
end
