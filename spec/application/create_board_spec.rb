# frozen_string_literal: true

require 'application/create_board'
require 'infrastructure/board_repository'
require 'domain/board'

RSpec.describe Application::CreateBoard do
  subject { described_class.new(board_repository) }

  let(:board_repository) { Infrastructure::BoardRepository.new }

  describe "#call" do
    it "creates a new board and saves it to the repository" do
      expect { subject.call }.to change { board_repository.fetch }.from(nil).to(an_instance_of(Domain::Board)) 
    end
  end
end
