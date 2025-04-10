# frozen_string_literal: true

require 'domain/coordinate'

module Application
  class AttackBoard
    attr_reader :board_repository

    def initialize(board_repository)
      @board_repository = board_repository
    end

    def call(x, y)
      board.receive_attack(build_coordinate(x, y))
    end

    private

    def build_coordinate(x, y)
      Domain::Coordinate.new(x, y)
    end

    def board
      @board ||= board_repository.fetch
    end
  end
end
