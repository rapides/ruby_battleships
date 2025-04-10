# frozen_string_literal: true

require 'domain/board'
require 'domain/ship'
require 'domain/coordinate'

module Application
  class CreateBoard
    attr_reader :board_repository

    def initialize(board_repository)
      @board_repository = board_repository
    end

    def call
      board_repository.save(init_board)
    end

    private

    def init_board
      Domain::Board.new([
        init_short_ship,
        init_long_ship
      ])
    end

    def init_short_ship
      Domain::Ship.new([Domain::Coordinate.new(1, 2), Domain::Coordinate.new(1, 3)])
    end

    def init_long_ship
      Domain::Ship.new([Domain::Coordinate.new(7, 8), Domain::Coordinate.new(8, 8), Domain::Coordinate.new(9, 8)])
    end
  end
end
