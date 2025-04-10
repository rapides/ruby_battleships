# frozen_string_literal: true

require 'application/attack_board'
require 'infrastructure/board_repository'
require 'domain/board'
require 'domain/coordinate'

RSpec.describe Application::AttackBoard do
  subject { described_class.new(board_repository) }

  let(:board_repository) { instance_double(Infrastructure::BoardRepository) }
  let(:board) { instance_double(Domain::Board) }
  let(:coordinate) { instance_double(Domain::Coordinate) }

  describe "#call" do
    before do
      allow(Domain::Coordinate).to receive(:new).with(1, 2).and_return(coordinate)
      allow(board).to receive(:receive_attack).and_return(Domain::Board::HIT)
      allow(board_repository).to receive(:fetch).and_return(board)
    end

    it 'returns the result of receive_attack' do
      expect(subject.call(1, 2)).to eq Domain::Board::HIT
    end
  end
end
