# frozen_string_literal: true

class Ship
  attr_reader :coordinates, :hits

  def initialize(coordinates)
    @coordinates = coordinates
    @hits = []
  end

  def hit?(coordinate)
    if coordinates.include?(coordinate) && !hits.include?(coordinate)
      hits << coordinate
      true
    else
      false
    end
  end

  def sunk?
    coordinates.all? { |coordinate| hits.include?(coordinate) }
  end
end
