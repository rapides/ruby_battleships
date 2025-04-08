# frozen_string_literal: true

require_relative '../../domain/coordinate'

RSpec.describe Coordinate do
  subject { Coordinate.new(x, y) }
  let(:x) { 1 }
  let(:y) { 2 }

  context "when X axis is out of bounds" do
    let(:x) { 10 }

    it "raises an error" do
      expect { subject }.to raise_error(ArgumentError, "Invalid coordinates")
    end
  end

  context "when Y axis is out of bounds" do
    let(:y) { 10 }

    it "raises an error" do
      expect { subject }.to raise_error(ArgumentError, "Invalid coordinates")
    end
  end

  describe "#==" do
    context "when coordinates are equal" do
      it "returns the result" do
        expect(subject == Coordinate.new(1, 2)).to be_truthy
      end
    end

    context "when X axis is not equal" do
      it "returns the result" do
        expect(subject == Coordinate.new(2, 2)).to be_falsey
      end
    end

    context "when Y axis is not equal" do
      it "returns the result" do
        expect(subject == Coordinate.new(1, 5)).to be_falsey
      end
    end
  end
end
