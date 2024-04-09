# frozen_string_literal: true

require "i18n"
require "yaml"

module RDockerize
  DEBUG = false

  STANDARD_COMPOSE_VERSION = 3.5.freeze

  DATABASE = %w[postgresql mysql mongodb sqlite].freeze

  JAVASCRIPT_PM = %w[yarn npm].freeze

  SUBSERVICES = %w[redis rabbitmq sidekiq].freeze

  I18n.load_path << File.join(File.dirname(__FILE__), "..", "config", "locales", "en.yml")
end
