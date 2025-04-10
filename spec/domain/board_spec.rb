# frozen_string_literal: true

require 'domain/board'

RSpec.describe Domain::Board do
  subject do
    described_class.new([
      Domain::Ship.new([Domain::Coordinate.new(4, 2), Domain::Coordinate.new(4, 3)]),
      Domain::Ship.new([Domain::Coordinate.new(1, 2), Domain::Coordinate.new(1, 3), Domain::Coordinate.new(1, 4)]),
    ])
  end

  describe '#receive_attack' do
    context 'when the coordinate hits a ship' do
      let(:coordinate) { Domain::Coordinate.new(4, 2) }

      it 'returns HIT' do
        expect(subject.receive_attack(coordinate)).to eq described_class::HIT
      end
    end

    context 'when the coordinate hits a ship and sinks it' do
      let(:coordinate) { Domain::Coordinate.new(1, 2) }

      before do
        subject.receive_attack(Domain::Coordinate.new(1, 3))
        subject.receive_attack(Domain::Coordinate.new(1, 4))
      end

      it 'returns SUNK' do
        expect(subject.receive_attack(coordinate)).to eq described_class::SUNK
      end
    end

    context 'when the coordinate misses' do
      let(:coordinate) { Domain::Coordinate.new(2, 2) }

      it 'returns MISHIT' do
        expect(subject.receive_attack(coordinate)).to eq described_class::MISHIT
      end
    end

    context 'when the coordinate has already been attacked' do
      let(:coordinate) { Domain::Coordinate.new(4, 2) }

      before do
        subject.receive_attack(coordinate)
      end

      it 'raises an ArgumentError' do
        expect { subject.receive_attack(coordinate) }.to raise_error(described_class::CoordinateAlreadyAttackedError)
      end
    end
  end

  describe '#all_ships_sunk?' do
    context 'when all ships are sunk' do
      before do
        subject.receive_attack(Domain::Coordinate.new(4, 2))
        subject.receive_attack(Domain::Coordinate.new(4, 3))
        subject.receive_attack(Domain::Coordinate.new(1, 2))
        subject.receive_attack(Domain::Coordinate.new(1, 3))
        subject.receive_attack(Domain::Coordinate.new(1, 4))
      end

      it 'returns true' do
        expect(subject.all_ships_sunk?).to be_truthy
      end
    end

    context 'when not all ships are sunk' do
      before do
        subject.receive_attack(Domain::Coordinate.new(4, 2))
        subject.receive_attack(Domain::Coordinate.new(4, 3))
        subject.receive_attack(Domain::Coordinate.new(1, 2))
        subject.receive_attack(Domain::Coordinate.new(1, 3))
        # Not attacking the last coordinate of the second ship
      end

      it 'returns false' do
        expect(subject.all_ships_sunk?).to be_falsey
      end
    end
  end
end
