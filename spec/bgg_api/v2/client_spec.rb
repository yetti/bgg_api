# frozen_string_literal: true

require "spec_helper"

RSpec.describe BggApi::V2::Client do
  subject(:client) { described_class.new }

  describe "#thing" do
    context "when the id is valid" do
      let(:id) { 24025 }

      it "returns an 200 status" do
        result = VCR.use_cassette("successful_thing") do
          client.thing({id: id})
        end

        expect(result[:status]).to eq(200)
      end
    end
  end
end
