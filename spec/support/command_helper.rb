# frozen_string_literal: true

require "open3"

class CommandHelper
  def run_command(command, chdir: nil, should_fail: false, env: {}, input: nil)
    output, error, status =
      Open3.capture3(
        env,
        command,
        chdir: chdir || File.expand_path("../..", __dir__),
        stdin_data: input&.join("\n")
      )

    if ENV["COMMAND_DEBUG"] || (!status.success? && !should_fail)
      puts "\n\nCOMMAND:\n#{command}\n\nOUTPUT:\n#{output}\nERROR:\n#{error}\n"
    end

    # status.success?.should == true unless should_fail

    yield status, output, error if block_given?
  end

  def run_rdockerize(command, **options, &block)
    run_command("ruby #{File.join(__dir__, "../../bin/rdockerize")} #{command}", **options, &block)
  end
end
