# frozen_string_literal: true

require "i18n"
require "yaml"

module RDockerize
  VERSION = "0.1.0"

  DEBUG = true

  STANDARD_COMPOSE_VERSION = 3.5.freeze

  JAVASCRIPT = %w[importmap esbuild webpack].freeze

  DATABASE = %w[pg postgresql mysql mongodb].freeze

  JAVASCRIPT_PM = %w[yarn npm].freeze

  SUBSERVICES = %w[redis rabbitmq sidekiq].freeze

  I18n.load_path << File.join(File.dirname(__FILE__), "..", "config", "locales", "en.yml")
end
