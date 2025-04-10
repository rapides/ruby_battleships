# frozen_string_literal: true

module Domain
  class Coordinate
    attr_reader :x, :y

    MAX_X_AXIS = 9.freeze
    MAX_Y_AXIS = 9.freeze

    class OutOfBoundaryError < StandardError
      def initialize(x, y)
        super("Invalid coordinate: (#{x}, #{y}) is out of bounds! #{instruction}")
      end

      private

      def instruction
        "Each coordinate must be between 0 and #{MAX_X_AXIS} for X and 0 and #{MAX_Y_AXIS} for Y."
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
      x&.between?(0, MAX_X_AXIS) && y&.between?(0, MAX_Y_AXIS)
    end
  end
end
