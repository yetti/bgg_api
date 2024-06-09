# frozen_string_literal: true

RSpec.describe BggApi do
  it "has a version number" do
    expect(BggApi::VERSION).not_to be_nil
  end
end
