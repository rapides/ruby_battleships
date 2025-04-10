# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path('lib', __dir__))

require 'infrastructure/board_repository'
require 'application/create_board'
require 'application/attack_board'
require 'application/check_board_sunk'
require 'interface/input_handler'
require 'interface/game_ui'

repo = Infrastructure::BoardRepository.new
create_board_service = Application::CreateBoard.new(repo)
attack_board_service = Application::AttackBoard.new(repo)
check_board_sunk_service = Application::CheckBoardSunk.new(repo)
input_handler = Interface::InputHandler.new(attack_board_service)
game_ui = Interface::GameUI.new(create_board_service, check_board_sunk_service, input_handler)

game_ui.start
