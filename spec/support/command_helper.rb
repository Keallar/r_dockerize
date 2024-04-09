# frozen_string_literal: true

require "open3"

module CommandHelper
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

    expect(status.success?).to be_truthy unless should_fail

    yield status, output, error if block_given?
  end

  def run_rdockerize(command, **options, &block)
    run_command("ruby #{File.join(__dir__, "../../bin/r_dockerize")} #{command}", **options, &block)
  end

  def run_rdockerize_without_subcommand(**options, &block)
    run_command("ruby #{File.join(__dir__, "../../bin/r_dockerize")}", **options, &block)
  end
end
