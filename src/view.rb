# frozen_string_literal: true

require 'matrix'
require_relative './observer/observer'

class BoardView < Observer
  def update(board_model)
    clean
    printBoard(board_model)
  end

  def print_actions
    puts 'Type number to choose action'
    puts '1 Unlock Square'
    puts '2 Flag Square'
    puts '3 Uncheck Square'
    puts '4 Exit Game'
  end

  def print_input_error
    puts 'Please enter a correct input'
  end

  def print_board(board_model)
    matrix = board_model.map
    puts "  012345678"
    puts "  ---------"
    counter = 0
    matrix.each do |row|
      squares = []
      row.each do |space|
        squares.push(space.item_view)
      end
      puts counter.to_s + "|" + squares.join('') + "|"
      counter += 1
    end
    puts "  ---------"
    STDOUT.flush
  end

  def print_enter_x
    puts 'Enter X coordinate'
  end

  def print_enter_y
    puts 'Enter Y coordinate'
  end

  def print_game_over
    puts 'Game Over!'
  end

  def print_no_F_in_map_error
    puts 'There is no F in the map so you can´t choose option 3 yet'
  end

  def print_flag_square_error
    puts 'You can´t flag a square which has already been unlocked'
  end

  def print_unlock_square_error
    puts 'You can´t unlock a square which has already been unlocked or flagged'
    puts 'If the square chosen is flagged, you can uncheck it and then unlock'
  end
end
