# frozen_string_literal: true

module RDockerize
  module Commands
    # rubocop disable:Style/IfUnlessModifier
    class Dco < Base
      attr_reader :db, :js, :subservices, :volumes

      def self.run(args)
        new(args).run
      end

      def initialize(args)
        @show = false
        @subservices = []
        @user_temp = false
        super(args)
      end

      def parse(args)
        @db = "sqlite"

        parser = opt_parser do |opts|
          opts.banner = banner

          opts.on("-s", "--show", "# Show assembled docker-compose file") do
            @show = true
          end

          opts.on("-u", "--user", "# Use saved user's template") do
            @user_temp = true
          end

          opts.on("-d", "--database=DATABASE", "# Choose database [options: sqlite]") do |val|
            prepare_db(val)
          end

          opts.on("-b", "--subservice=SUBSERVICE", "# Choose subservice [options: redis rabbitmq sidekiq]") do |val|
            prepare_subservices(val)
          end
        end

        parser.parse!(args)
      end

      def run
        text = prepare_text
        return $stdout.puts text if @show

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
        USAGE
      end

      private

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

        @subservices << option
      end

      def prepare_text
        return I18n.t("#{BASE_KEY}.dco.user_template") if @user_temp

        js_text = I18n.t("#{BASE_KEY}.dco.js.#{@js}") if js_text
        db_text = I18n.t("#{BASE_KEY}.dco.db.#{@db}")
        subservice_text = if @subservices
                            @subservices.each_with_object([]) do |service, str_arr|
                              str_arr << "#{I18n.t("#{BASE_KEY}.dco.subservices.#{service.dup}")}\n"
                            end.join(" ")
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
