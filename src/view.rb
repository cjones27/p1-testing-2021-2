# frozen_string_literal: true

class BoardView
  def print_board(board_model)
    matrix = board_model.map

    matrix.each do |row|
      squares = []
      row.each do |space|
        squares.push(space.item)
      end

      puts squares.join('')
    end
  end

  def print_actions
    puts 'Type number to choose action'
    puts '1 Display Board'
    puts '2 Unlock Square'
    puts '3 Flag Square'
    puts '4 Exit Game'
    action = gets
    print_input_error unless %w[1 2 3 4].include?(action)
    action
  end

  def get_position
    puts 'Choose Square, type row number'
    row = gets
    puts 'Type column number'
    col = gets
    [row, col]
  end

  private

  def print_input_error
    puts 'Please enter a correct input'
    print_actions
  end
end
