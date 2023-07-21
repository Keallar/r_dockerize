# frozen_string_literal: true

require_relative "base"

module RDockerize
  module Errors
    class SubserviceNotFound < Base
      def initialize(attrs)
        @key = "subservice_not_found"
        @attrs = attrs
        super(create_message)
      end
    end
  end
end
