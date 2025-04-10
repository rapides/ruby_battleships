# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path('lib', __dir__))

require 'domain/board'
require 'domain/ship'
require 'domain/coordinate'

board = Domain::Board.new([
  Domain::Ship.new([Domain::Coordinate.new(1, 2), Domain::Coordinate.new(1, 3)]),
  Domain::Ship.new([Domain::Coordinate.new(7, 8), Domain::Coordinate.new(8, 8), Domain::Coordinate.new(9, 8)]),
])

puts 'Welcome to the Battleship game!'
loop do
  print 'Enter the coordinates of the attack (e.g. 1,2): '
  input = gets.strip
  x, y = input.split(',').map(&:to_i)
  coordinate = Domain::Coordinate.new(x, y)

  event = board.receive_attack(coordinate)

  puts '💥 The ship has been sunk!' if event == Domain::Board::SUNK
  puts '🎯 Hit!' if event == Domain::Board::HIT
  puts '🌊 Mishit!' if event == Domain::Board::MISHIT

  break if board.all_ships_sunk?
rescue Domain::Coordinate::OutOfBoundaryError, Domain::Board::CoordinateAlreadyAttackedError => e
  puts "🚫 #{e.message}"
end

puts '🏁 All the ships have been sunk! Game over.'
