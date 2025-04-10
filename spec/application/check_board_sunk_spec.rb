# frozen_string_literal: true

require 'application/check_board_sunk'
require 'infrastructure/board_repository'
require 'domain/board'

RSpec.describe Application::CheckBoardSunk do
  subject { described_class.new(board_repository) }

  let(:board_repository) { instance_double(Infrastructure::BoardRepository) }
  let(:board) { instance_double(Domain::Board) }

  describe "#call" do
    before do
      allow(board).to receive(:all_ships_sunk?).and_return('result')
      allow(board_repository).to receive(:fetch).and_return(board)
    end

    it 'returns the result of all_ships_sunk?' do
      expect(subject.call).to eq 'result'
    end
  end
end
