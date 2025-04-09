# frozen_string_literal: true

class Board
  attr_reader :ships, :hits

  MISHIT = :mishit
  HIT    = :hit
  SUNK   = :sunk

  def initialize(ships)
    @ships = ships
    @hits  = []
  end

  def attack(coordinate)
    raise ArgumentError, 'Coordinate already attacked' if hit_exists?(coordinate)

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
