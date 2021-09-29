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
    action = @view.print_actions
    # action = $stdin.gets.to_i
    handle_main_menu_action(action)
  end

  def handle_main_menu_action(action)
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

  def receive_input
    x = @view.print_enter_x
    y = @view.print_enter_y

    [x, y]
  end

  def coords_input(input_x, input_y)
    return false unless @model.check_if_valid_coordinate('x', input_x)

    return false unless @model.check_if_valid_coordinate('y', input_y)

    [x.to_i, y.to_i]
  end

  def unlock_square
    inputs = receive_input
    coords = coords_input(inputs[0], inputs[1])
    if coords == false
      handle_unlock_coords_false
      return
    end

    x = coords[0]
    y = coords[1]

    resultado_jugada = @model.unlock_square(y, x)
    handle_unlock_square_result(resultado_jugada)
  end

  def handle_unlock_coords_false
    print_input_error
    unlock_square
  end

  def handle_unlock_square_result(resultado_jugada)
    case resultado_jugada
    when 'game over'
      @view.print_game_over(@model)
    when 'game winner'
      @view.print_game_winner(@model)
    when 'square already unlocked'
      handle_square_already_unlocked
    else
      main_menu
    end
  end

  def handle_square_already_unlocked
    @view.print_unlock_square_error
    main_menu
  end

  def flag_unflag_square
    inputs = receive_input
    coords = coords_input(inputs[0], inputs[1])
    if coords == false
      handle_unflag_coords_false
      return
    end

    x = coords[0]
    y = coords[1]

    @view.print_flag_square_error if @model.flag_unflag_square(y, x) == 'square already unlocked'
    main_menu
  end

  def handle_unflag_coords_false
    print_input_error
    flag_unflag_square
  end
end
