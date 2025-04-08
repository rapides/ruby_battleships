# frozen_string_literal: true

require_relative '../config/game_config'

class Coordinate
  attr_reader :x, :y

  def initialize(x, y)
    raise ArgumentError, "Invalid coordinates" unless valid?(x, y)
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
