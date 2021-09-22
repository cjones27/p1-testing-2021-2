# frozen_string_literal: true

require_relative 'view'
require_relative 'model'

class BoardController
  def initialize(view, model)
    @board_view = view
    @board_model = model
    start_game
  end

  def start_game
    loop do
      @board_view.print_board(@board_model)
      @board_view.print_actions
    end
  end
end

game = BoardController.new(BoardView.new, BoardModel.new)
