# frozen_string_literal: true

require_relative '../../domain/board'

RSpec.describe Board do
  subject do
    Board.new([
      Ship.new([Coordinate.new(4, 2), Coordinate.new(4, 3)]),
      Ship.new([Coordinate.new(1, 2), Coordinate.new(1, 3), Coordinate.new(1, 4)]),
    ])
  end

  describe '#attack' do
    context 'when the coordinate hits a ship' do
      let(:coordinate) { Coordinate.new(4, 2) }

      it 'returns HIT' do
        expect(subject.attack(coordinate)).to eq Board::HIT
      end
    end

    context 'when the coordinate hits a ship and sinks it' do
      let(:coordinate) { Coordinate.new(1, 2) }

      before do
        subject.attack(Coordinate.new(1, 3))
        subject.attack(Coordinate.new(1, 4))
      end

      it 'returns SUNK' do
        expect(subject.attack(coordinate)).to eq Board::SUNK
      end
    end

    context 'when the coordinate misses' do
      let(:coordinate) { Coordinate.new(2, 2) }

      it 'returns MISHIT' do
        expect(subject.attack(coordinate)).to eq Board::MISHIT
      end
    end

    context 'when the coordinate has already been attacked' do
      let(:coordinate) { Coordinate.new(4, 2) }

      before do
        subject.attack(coordinate)
      end

      it 'raises an ArgumentError' do
        expect { subject.attack(coordinate) }.to raise_error(ArgumentError, 'Coordinate already attacked')
      end
    end
  end

  describe '#all_ships_sunk?' do
    context 'when all ships are sunk' do
      before do
        subject.attack(Coordinate.new(4, 2))
        subject.attack(Coordinate.new(4, 3))
        subject.attack(Coordinate.new(1, 2))
        subject.attack(Coordinate.new(1, 3))
        subject.attack(Coordinate.new(1, 4))
      end

      it 'returns true' do
        expect(subject.all_ships_sunk?).to be_truthy
      end
    end

    context 'when not all ships are sunk' do
      before do
        subject.attack(Coordinate.new(4, 2))
        subject.attack(Coordinate.new(4, 3))
        subject.attack(Coordinate.new(1, 2))
        subject.attack(Coordinate.new(1, 3))
        # Not attacking the last coordinate of the second ship
      end

      it 'returns false' do
        expect(subject.all_ships_sunk?).to be_falsey
      end
    end
  end
end
