# frozen_string_literal: true

require 'matrix'

class BoardController
  def initialize(board_model, board_view)
    @model = board_model
    @view = board_view
  end

  def request_input
    @view.print_board(@model)
    @view.print_actions
    action = $stdin.gets.to_i

    if action == 1
      # unlock square
      unlock_square
      # if action == 2 then
      #   # flag square
      # if action == 3 then
      # exit game
    else
      # invalid action
      print_input_error
    end
  end

  def display_board
    @view.print_board(@model)
    request_input
  end

  def print_input_error
    @view.print_input_error
    request_input
  end

  def unlock_square
    @view.print_enter_x
    x = $stdin.gets.to_i

    print_input_error unless @model.check_if_valid_coordinate('x', x)

    @view.print_enter_y
    y = $stdin.gets.to_i

    print_input_error unless @model.check_if_valid_coordinate('y', y)

    if @model.unlock_square(y, x) == 'game over'
      @view.print_game_over
      @view.print_board(@model)
    else
      request_input
    end
  end
end
