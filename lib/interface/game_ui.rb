# frozen_string_literal: true

module Interface
  class GameUI
    attr_reader :create_board_service,
                :check_board_sunk_service,
                :input_handler

    def initialize(create_board_service, check_board_sunk_service, input_handler)
      @create_board_service = create_board_service
      @check_board_sunk_service = check_board_sunk_service
      @input_handler = input_handler
    end

    def start
      create_board_service.call
      puts 'Welcome to the Battleship game!'
      loop do
        print 'Enter the coordinates of the attack (e.g. 1,2): '
        input = gets.strip
        puts input_handler.call(input)
        break if check_board_sunk_service.call
      end
      puts '🏁 All the ships have been sunk! Game over.'
    end
  end
end
