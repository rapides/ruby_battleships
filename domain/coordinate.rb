# frozen_string_literal: true

require_relative '../config/game_config'

class Coordinate
  attr_reader :x, :y

  class OutOfBoundaryError < StandardError
    def initialize(x, y)
      super("Invalid coordinate: (#{x}, #{y}) is out of bounds! #{instruction}")
    end

    private

    def instruction
      "Each coordinate must be between 0 and #{GameConfig::MAX_X_AXIS} for X and 0 and #{GameConfig::MAX_Y_AXIS} for Y."
    end
  end

  def initialize(x, y)
    raise OutOfBoundaryError.new(x, y) unless valid?(x, y)

    @x = x
    @y = y
  end

  def ==(other)
    x == other.x && y == other.y
  end

  private

  def valid?(x, y)
    x.between?(0, GameConfig::MAX_X_AXIS) && y.between?(0, GameConfig::MAX_Y_AXIS)
  end
end
