# frozen_string_literal: true

class BoardSquare
  def initialize(item)
    @visible = item == ' '
    @flagged = false
    @item = item
  end

  def flag
    @flagged = if @flagged
                 false
               else
                 true
               end
  end

  def make_visible
    @visible = true
    @flagged = false
  end

  def item
    if @flagged
      'F'
    elsif !@visible
      '?'
    else
      @item
    end
  end
end

class BoardModel
  attr_accessor :map

  def initialize
    @map = [
      [BoardSquare.new('B'), BoardSquare.new('3'), BoardSquare.new('B'), BoardSquare.new('1'),
       BoardSquare.new(' '), BoardSquare.new(' '), BoardSquare.new(' '), BoardSquare.new(' '), BoardSquare.new(' ')],
      [BoardSquare.new('2'), BoardSquare.new('B'), BoardSquare.new('2'), BoardSquare.new('1'),
       BoardSquare.new(' '), BoardSquare.new(' '), BoardSquare.new('1'), BoardSquare.new('1'), BoardSquare.new('1')],
      [BoardSquare.new('1'), BoardSquare.new('1'), BoardSquare.new('1'), BoardSquare.new(' '),
       BoardSquare.new(' '), BoardSquare.new(' '), BoardSquare.new('1'), BoardSquare.new('B'), BoardSquare.new('1')],
      [BoardSquare.new(' '), BoardSquare.new(' '), BoardSquare.new(' '), BoardSquare.new(' '),
       BoardSquare.new(' '), BoardSquare.new(' '), BoardSquare.new('1'), BoardSquare.new('1'), BoardSquare.new('1')],
      [BoardSquare.new(' '), BoardSquare.new(' '), BoardSquare.new(' '), BoardSquare.new('1'),
       BoardSquare.new('1'), BoardSquare.new('2'), BoardSquare.new('2'), BoardSquare.new('2'), BoardSquare.new('1')],
      [BoardSquare.new(' '), BoardSquare.new(' '), BoardSquare.new(' '), BoardSquare.new('1'),
       BoardSquare.new('B'), BoardSquare.new('3'), BoardSquare.new('B'), BoardSquare.new('B'), BoardSquare.new('1')],
      [BoardSquare.new(' '), BoardSquare.new(' '), BoardSquare.new(' '), BoardSquare.new('1'),
       BoardSquare.new('1'), BoardSquare.new('3'), BoardSquare.new('B'), BoardSquare.new('3'), BoardSquare.new('1')],
      [BoardSquare.new(' '), BoardSquare.new(' '), BoardSquare.new(' '), BoardSquare.new('1'),
       BoardSquare.new('1'), BoardSquare.new('2'), BoardSquare.new('2'), BoardSquare.new('2'), BoardSquare.new('1')],
      [BoardSquare.new(' '), BoardSquare.new(' '), BoardSquare.new(' '), BoardSquare.new('1'),
       BoardSquare.new('B'), BoardSquare.new('1'), BoardSquare.new('1'), BoardSquare.new('B'), BoardSquare.new('1')]
    ]

    @cleared_squares = 0
  end

  def count_clear_square
    @cleared_squares += 1
  end
end
