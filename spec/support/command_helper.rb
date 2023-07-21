# frozen_string_literal: true

require "open3"

module CommandHelper
  def run_command(command)
    output, error, status = Open3.capture3(command)
  end
end
