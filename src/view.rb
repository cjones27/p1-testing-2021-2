# frozen_string_literal: true

require 'matrix'
require_relative './observer/observer'

# BoardView
class BoardView < Observer
  def update(board_model)
    clean
    printBoard(board_model)
  end

  def print_actions
    puts 'Type number to choose action'
    puts '1 Unlock Square'
    puts '2 Flag/unflag Square'
    puts '3 Exit Game'
  end

  def print_input_error
    puts ' '
    puts 'Please enter a correct input'
  end

  def print_board(board_model)
    matrix = board_model.map
    puts '  01234567'
    puts '  ---------'
    print_matrix(matrix)
    puts '  ---------'
    $stdout.flush
  end

  def print_matrix(matrix)
    counter = 0
    matrix.each do |row|
      squares = []
      row.each do |space|
        squares.push(space.item_view)
      end
      puts "#{counter}|#{squares.join('')}|"
      counter += 1
    end
  end

  def print_enter_x
    puts 'Enter X coordinate'
  end

  def print_enter_y
    puts 'Enter Y coordinate'
  end

  def print_game_over(board_model)
    print_board(board_model)
    puts 'Game Over!'
  end

  def print_game_winner(board_model)
    print_board(board_model)
    puts 'You won! Congratulations :)'
  end

  def print_no_flag_in_map_error
    puts 'There is no F in the map so you can´t choose option 3 yet'
  end

  def print_flag_square_error
    puts 'You can´t flag a square which has already been unlocked'
  end

  def print_unlock_square_error
    puts 'You can´t unlock a square which has already been unlocked or flagged'
    puts 'If the square chosen is flagged, you can unflag it and then unlock'
  end

  def print_exit
    puts 'See you soon! :)'
  end
end
