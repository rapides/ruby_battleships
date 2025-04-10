# frozen_string_literal: true

require 'interface/input_handler'
require 'application/attack_board'
require 'domain/board'
require 'domain/coordinate'

RSpec.describe Interface::InputHandler do
  subject { described_class.new(attack_board_service) }

  let(:attack_board_service) { instance_double(Application::AttackBoard) }

  describe "#call" do
    let(:coordinate_x) { 1 }
    let(:coordinate_y) { 2 }

    context 'when the input is mishit' do
      let(:event) { Domain::Board::MISHIT }

      before do
        allow(attack_board_service).to receive(:call).with(coordinate_x, coordinate_y).and_return(event)
      end

      it 'returns the result of receive_attack' do
        expect(subject.call("#{coordinate_x},#{coordinate_y}")).to include('Mishit!')
      end
    end

    context 'when the input is hit' do
      let(:event) { Domain::Board::HIT }

      before do
        allow(attack_board_service).to receive(:call).with(coordinate_x, coordinate_y).and_return(event)
      end

      it 'returns the result of receive_attack' do
        expect(subject.call("#{coordinate_x},#{coordinate_y}")).to include('Hit!')
      end
    end

    context 'when the input is sunk' do
      let(:event) { Domain::Board::SUNK }

      before do
        allow(attack_board_service).to receive(:call).with(coordinate_x, coordinate_y).and_return(event)
      end

      it 'returns the result of receive_attack' do
        expect(subject.call("#{coordinate_x},#{coordinate_y}")).to include('The ship has been sunk!')
      end
    end

    context 'when the input is out of boundary' do
      let(:error) { Domain::Coordinate::OutOfBoundaryError.new(coordinate_x, coordinate_y) }

      before do
        allow(attack_board_service).to receive(:call).with(coordinate_x, coordinate_y).and_raise(error)
      end

      it 'returns the result of receive_attack' do
        expect(subject.call("#{coordinate_x},#{coordinate_y}")).to include('is out of bounds!')
      end
    end

    context 'when the coordinate has already been attacked' do
      let(:error) do
        Domain::Board::CoordinateAlreadyAttackedError.new(
          Domain::Coordinate.new(coordinate_x, coordinate_y)
        )
      end

      before do
        allow(attack_board_service).to receive(:call).with(coordinate_x, coordinate_y).and_raise(error)
      end

      it 'returns the result of receive_attack' do
        expect(subject.call("#{coordinate_x},#{coordinate_y}")).to include('Coordinate already attacked')
      end
    end

    context 'when the input is invalid' do
      let(:error) { Domain::Coordinate::OutOfBoundaryError.new(coordinate_x, coordinate_y) }
      let(:coordinate_x) { 0 }
      let(:coordinate_y) { nil }

      before do
        allow(attack_board_service).to receive(:call).with(coordinate_x, coordinate_y).and_raise(error)
      end

      it 'returns the result of receive_attack' do
        expect(subject.call("#{coordinate_x},#{coordinate_y}")).to include('is out of bounds!')
      end
    end
  end
end
