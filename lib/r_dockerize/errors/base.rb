# frozen_string_literal: true

module RDockerize
  module Errors
    class Base < StandardError
      BASE_KEY = "r_dockerize.errors.messages"

      attr_reader :key, :attrs

      def create_message
        I18n.t("#{BASE_KEY}.#{key}", **{ locale: :en }.merge(attrs))
      end
    end
  end
end
