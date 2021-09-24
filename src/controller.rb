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
      unlock_square
    elsif action == 2 
      flag_square
    elsif action == 3
      uncheck_square
    elsif action == 4
      exit_game
    else
      print_input_error
      request_input
    end
  end

  def display_board
    @view.print_board(@model)
    request_input
  end

  def print_input_error
    @view.print_input_error
  end

  def unlock_square
    @view.print_enter_x
    x = $stdin.gets.to_i

    #print_input_error unless @model.check_if_valid_coordinate('x', x)
    if @model.check_if_valid_coordinate('x', x) == false
      print_input_error
      unlock_square
      return 
    end

    @view.print_enter_y
    y = $stdin.gets.to_i

    #print_input_error unless @model.check_if_valid_coordinate('y', y)
    if @model.check_if_valid_coordinate('y', y) == false
      print_input_error
      unlock_square
      return 
    end

    if @model.map[y][x].item_view != '?'
      print_input_error
      @view.print_unlock_square_error
      request_input
      return 
    end

    if @model.unlock_square(y, x) == 'game over'
      @view.print_board(@model)
      exit_game
    else
      request_input
    end
  end

  def flag_square
    @view.print_enter_x
    x = $stdin.gets.to_i
    if @model.check_if_valid_coordinate('x', x) == false
      print_input_error
      flag_square
      return 
    end

    @view.print_enter_y
    y = $stdin.gets.to_i
    if @model.check_if_valid_coordinate('y', y) == false
      print_input_error
      flag_square
      return 
    end

    if @model.map[y][x].item_view != '?'
      print_input_error
      @view.print_flag_square_error
      flag_square
      return 
    end

    @model.flag_square(y, x)
    request_input
  end

  def uncheck_square
    if check_F_in_map == true
      @view.print_enter_x
      x = $stdin.gets.to_i
      if @model.check_if_valid_coordinate('x', x) == false
        print_input_error
        uncheck_square
        return 
      end

      @view.print_enter_y
      y = $stdin.gets.to_i
      if @model.check_if_valid_coordinate('y', y) == false
        print_input_error
        uncheck_square
        return 
      end

      if @model.map[y][x].item_view != 'F'
        print_input_error
        uncheck_square
        return 
      end

      @model.uncheck_square(y, x)
      request_input
    else 
      print_input_error
      @view.print_no_F_in_map_error
      request_input
    end
  end

  def check_F_in_map
    matrix = @model.map
    matrix.each do |row|
      row.each do |space|
        if space.item_view == 'F'
          return true
        end
      end
    end
    return false
  end

  def exit_game
    @view.print_game_over
  end
end
