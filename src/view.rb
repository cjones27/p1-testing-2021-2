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
    puts '3 Exit Game'
  end

  def print_input_error
    puts 'Please enter a correct input'
  end

  def print_board(board_model)
    matrix = board_model.map

    matrix.each do |row|
      squares = []
      row.each do |space|
        squares.push(space.item_view)
      end

      puts squares.join('')
    end
    STDOUT.flush
  end

  def print_enter_x
    puts 'Enter X coordinate'
  end

  def print_enter_y
    puts 'Enter y coordinate'
  end

  def print_game_over
    puts 'Game Over!'
  end
end
