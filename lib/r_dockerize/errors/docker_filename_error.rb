# frozen_string_literal: true

# frozen_string_literal: true

module RDockerize
  module Errors
    class DockerFilenameError < Base
      def initialize(attrs = {})
        @key = "docker_filename_error"
        @attrs = attrs
        super(create_message)
      end
    end
  end
end
