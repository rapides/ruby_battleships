# frozen_string_literal: true

module Interface
  class InputHandler
    attr_reader :attack_board_service

    def initialize(attack_board_service)
      @attack_board_service = attack_board_service
    end

    def call(command)
      x, y = format_input(command)
      event = attack_board_service.call(x, y)
      format_message(event)
    rescue Domain::Coordinate::OutOfBoundaryError, Domain::Board::CoordinateAlreadyAttackedError => e
      "🚫 #{e.message}"
    end

    private

    def format_input(input)
      input.split(',')
           .map(&:to_i)
    end

    def format_message(event)
      case event
      when Domain::Board::SUNK
        '💥 The ship has been sunk!'
      when Domain::Board::HIT
        '🎯 Hit!'
      when Domain::Board::MISHIT
        '🌊 Mishit!'
      else
        '🚫 Invalid event'
      end
    end
  end
end
