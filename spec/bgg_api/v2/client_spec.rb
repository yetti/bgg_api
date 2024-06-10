# frozen_string_literal: true

require "spec_helper"

RSpec.describe BggApi::V2::Client do
  subject(:client) { described_class.new }

  describe "#thing" do
    context "when the id exists" do
      let(:id) { 1 }

      it "returns an 200 status" do
        result = VCR.use_cassette("existing_thing") do
          client.thing({id: id})
        end

        expect(result[:status]).to eq(200)
      end
    end

    context "when the id doesn't exist" do
      let(:id) { 0 }

      it "returns a 200 status" do
        result = VCR.use_cassette("nonexistent_thing") do
          client.thing({id: id})
        end

        expect(result[:status]).to eq(200)
      end
    end

    context "when id parameter is missing" do
      it "raises an ArgumentError" do
        expect { client.thing({}) }.to raise_error(ArgumentError)
      end
    end
  end
end
