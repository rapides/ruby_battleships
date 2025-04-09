# frozen_string_literal: true

require_relative '../../domain/ship'

RSpec.describe Ship do
  subject { Ship.new(init_coordinates) }
  let(:init_coordinates) { [Coordinate.new(1, 2), Coordinate.new(1, 3)] }

  describe "#hit?" do
    context "when the coordinate is part of the ship" do
      let(:coordinate) { Coordinate.new(1, 2) }
      it "returns true" do
        expect(subject.hit?(coordinate)).to be_truthy
      end
    end
    context "when the coordinate is not part of the ship" do
      let(:coordinate) { Coordinate.new(2, 2) }
      it "returns false" do
        expect(subject.hit?(coordinate)).to be_falsey
      end
    end
    context "when the coordinate is already hit" do
      let(:coordinate) { Coordinate.new(1, 2) }
      before { subject.hit?(coordinate) }
      it "returns false" do
        expect(subject.hit?(coordinate)).to be_falsey
      end
    end
  end

  describe "#sunk?" do
    context "when all coordinates are hit" do
      before do
        subject.hit?(Coordinate.new(1, 2))
        subject.hit?(Coordinate.new(1, 3))
      end

      it "returns true" do
        expect(subject.sunk?).to be_truthy
      end
    end

    context "when not all coordinates are hit" do
      before { subject.hit?(Coordinate.new(1, 2)) }

      it "returns false" do
        expect(subject.sunk?).to be_falsey
      end
    end
  end
end
