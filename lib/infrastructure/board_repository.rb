# frozen_string_literal: true

module Infrastructure
  class BoardRepository
    @@storage = nil

    def initialize; end

    def save(board)
      @@storage = board
    end

    def fetch
      @@storage
    end
  end
end
