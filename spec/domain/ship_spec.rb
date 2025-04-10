# frozen_string_literal: true

require 'domain/ship'

RSpec.describe Domain::Ship do
  subject { described_class.new(init_coordinates) }
  let(:init_coordinates) { [Domain::Coordinate.new(1, 2), Domain::Coordinate.new(1, 3)] }

  describe "#hit?" do
    context "when the coordinate is part of the ship" do
      let(:coordinate) { Domain::Coordinate.new(1, 2) }
      it "returns true" do
        expect(subject.hit?(coordinate)).to be_truthy
      end
    end

    context "when the coordinate is not part of the ship" do
      let(:coordinate) { Domain::Coordinate.new(2, 2) }
      it "returns false" do
        expect(subject.hit?(coordinate)).to be_falsey
      end
    end

    context "when the coordinate is already hit" do
      let(:coordinate) { Domain::Coordinate.new(1, 2) }
      before { subject.hit?(coordinate) }
      it "returns false" do
        expect(subject.hit?(coordinate)).to be_falsey
      end
    end
  end

  describe "#sunk?" do
    context "when all coordinates are hit" do
      before do
        subject.hit?(Domain::Coordinate.new(1, 2))
        subject.hit?(Domain::Coordinate.new(1, 3))
      end

      it "returns true" do
        expect(subject.sunk?).to be_truthy
      end
    end

    context "when not all coordinates are hit" do
      before { subject.hit?(Domain::Coordinate.new(1, 2)) }

      it "returns false" do
        expect(subject.sunk?).to be_falsey
      end
    end
  end
end
