# frozen_string_literal: true

require 'matrix'

# BoardController
class BoardController
  def initialize(board_model, board_view)
    @model = board_model
    @view = board_view
  end

  def main_menu
    @view.print_board(@model)
    @view.print_actions
    action = $stdin.gets.to_i

    case action
    when 1
      unlock_square
    when 2
      flag_unflag_square
    when 3
      @view.print_exit
    else
      handle_input_error
    end
  end

  def handle_input_error
    @view.print_input_error
    main_menu
  end

  def print_input_error
    @view.print_input_error
  end

  def coords_input
    @view.print_enter_x

    x = $stdin.gets.to_i
    return false if @model.check_if_valid_coordinate('x', x) == false

    @view.print_enter_y
    y = $stdin.gets.to_i
    return false if @model.check_if_valid_coordinate('y', y) == false

    [x, y]
  end

  def unlock_square
    coords = coords_input
    if coords == false
      print_input_error
      unlock_square
      return
    end

    x = coords[0]
    y = coords[1]

    resultado_jugada = @model.unlock_square(y, x)

    case resultado_jugada
    when 'game over'
      @view.print_game_over(@model)
    when 'game winner'
      @view.print_game_winner(@model)
    when 'square already unlocked'
      @view.print_unlock_square_error
      main_menu
    else
      main_menu
    end
  end

  def flag_unflag_square
    coords = coords_input
    if coords == false
      print_input_error
      flag_unflag_square
      return
    end

    x = coords[0]
    y = coords[1]

    @view.print_flag_square_error if @model.flag_unflag_square(y, x) == 'square already unlocked'
    main_menu
  end
end
