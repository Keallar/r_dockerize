# frozen_string_literal: true

module RDockerize
  module Errors
    class JsNotFound < Base
      def initialize(attrs)
        @key = "js_not_found"
        @attrs = attrs
        super(create_message)
      end
    end
  end
end
