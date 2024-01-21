# frozen_string_literal: true

require_relative "../spec_helper"

RSpec.describe "rdockerize save" do
  context "for Dockerfile" do
    it "" do
      run_rdockerize("save") do |_status, _output, _error|
      end
    end
  end
end
