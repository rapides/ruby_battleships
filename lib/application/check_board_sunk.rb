# frozen_string_literal: true

module Application
  class CheckBoardSunk
    attr_reader :board_repository

    def initialize(board_repository)
      @board_repository = board_repository
    end

    def call
      board.all_ships_sunk?
    end

    private

    def board
      @board ||= board_repository.fetch
    end
  end
end
