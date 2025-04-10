# frozen_string_literal: true

module Domain
  class Board
    attr_reader :ships, :hits

    MISHIT = :mishit
    HIT    = :hit
    SUNK   = :sunk

    class CoordinateAlreadyAttackedError < StandardError
      def initialize(coordinate)
        super("Coordinate already attacked: (#{coordinate.x}, #{coordinate.y})")
      end
    end

    def initialize(ships)
      @ships = ships
      @hits  = []
    end

    def receive_attack(coordinate)
      raise CoordinateAlreadyAttackedError.new(coordinate) if hit_exists?(coordinate)

      hits << coordinate
      ship = find_ship_hit(coordinate)
      return MISHIT unless ship
      return HIT unless ship.sunk?
      SUNK
    end

    def all_ships_sunk?
      ships.all?(&:sunk?)
    end

    private

    def hit_exists?(coordinate)
      hits.include?(coordinate)
    end

    def find_ship_hit(coordinate)
      ships.find { |ship| ship.hit?(coordinate) }
    end
  end
end
