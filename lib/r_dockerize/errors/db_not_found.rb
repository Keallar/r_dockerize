# frozen_string_literal: true

module RDockerize
  module Errors
    class DbNotFound < Base
      def initialize(attrs)
        @key = "db_not_found"
        @attrs = attrs
        super(create_message)
      end
    end
  end
end
