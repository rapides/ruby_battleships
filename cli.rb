# frozen_string_literal: true

require_relative 'domain/board'
require_relative 'domain/ship'
require_relative 'domain/coordinate'

board = Board.new([
  Ship.new([Coordinate.new(1, 2), Coordinate.new(1, 3)]),
  Ship.new([Coordinate.new(7, 8), Coordinate.new(8, 8), Coordinate.new(9, 8)]),
])

puts 'Welcome to the Battleship game!'
loop do
  print 'Enter the coordinates of the attack (e.g. 1,2): '
  input = gets.strip
  x, y = input.split(',').map(&:to_i)
  coordinate = Coordinate.new(x, y)

  event = board.receive_attack(coordinate)

  puts '💥 The ship has been sunk!' if event == Board::SUNK
  puts '🎯 Hit!' if event == Board::HIT
  puts '🌊 Mishit!' if event == Board::MISHIT

  break if board.all_ships_sunk?
rescue Coordinate::OutOfBoundaryError, Board::CoordinateAlreadyAttackedError => e
  puts "🚫 #{e.message}"
end

puts '🏁 All the ships have been sunk! Game over.'
