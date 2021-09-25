# frozen_string_literal: true

require_relative './observer/observable'
require 'matrix'

class BoardSquare
  attr_reader :item
  # Los siguientes reader son solo para acceder a los atributos al testear
  attr_reader :flagged 
  attr_reader :visible
  
  def initialize(item)
    # @visible = item == ' '
    @visible = false
    @flagged = false
    @item = item
  end

  def flag
    @flagged = !@flagged
  end

  def make_visible
    @visible = true
    @flagged = false
  end

  def item_view
    if @flagged
      'F'
    elsif !@visible
      '?'
    else
      @item
    end
  end

end

class BoardModel < Observable
  attr_accessor :map
  attr_accessor :cleared_squares

  # Siguientes reader son para usar en los tests
  
  attr_reader :length
  attr_reader :width

  def initialize
    @map = [
      [BoardSquare.new('B'), BoardSquare.new('3'), BoardSquare.new('B'),
       BoardSquare.new('1'), BoardSquare.new('0'), BoardSquare.new('0'),
       BoardSquare.new('0'), BoardSquare.new('0'), BoardSquare.new('0')],
      [BoardSquare.new('2'), BoardSquare.new('B'), BoardSquare.new('2'),
       BoardSquare.new('1'), BoardSquare.new('0'), BoardSquare.new('0'),
       BoardSquare.new('1'), BoardSquare.new('1'), BoardSquare.new('1')],
      [BoardSquare.new('1'), BoardSquare.new('1'), BoardSquare.new('1'),
       BoardSquare.new('0'), BoardSquare.new('0'), BoardSquare.new('0'),
       BoardSquare.new('1'), BoardSquare.new('B'), BoardSquare.new('1')],
      [BoardSquare.new('0'), BoardSquare.new('0'), BoardSquare.new('0'),
       BoardSquare.new('0'), BoardSquare.new('0'), BoardSquare.new('0'),
       BoardSquare.new('1'), BoardSquare.new('1'), BoardSquare.new('1')],
      [BoardSquare.new('0'), BoardSquare.new('0'), BoardSquare.new('0'),
       BoardSquare.new('1'), BoardSquare.new('1'), BoardSquare.new('2'),
       BoardSquare.new('2'), BoardSquare.new('2'), BoardSquare.new('1')],
      [BoardSquare.new('0'), BoardSquare.new('0'), BoardSquare.new('0'),
       BoardSquare.new('1'), BoardSquare.new('B'), BoardSquare.new('3'),
       BoardSquare.new('B'), BoardSquare.new('B'), BoardSquare.new('1')],
      [BoardSquare.new('0'), BoardSquare.new('0'), BoardSquare.new('0'),
       BoardSquare.new('1'), BoardSquare.new('1'), BoardSquare.new('3'),
       BoardSquare.new('B'), BoardSquare.new('3'), BoardSquare.new('1')],
      [BoardSquare.new('0'), BoardSquare.new('0'), BoardSquare.new('0'),
       BoardSquare.new('1'), BoardSquare.new('1'), BoardSquare.new('2'),
       BoardSquare.new('2'), BoardSquare.new('2'), BoardSquare.new('1')],
      [BoardSquare.new('0'), BoardSquare.new('0'), BoardSquare.new('0'),
       BoardSquare.new('1'), BoardSquare.new('B'), BoardSquare.new('1'),
       BoardSquare.new('1'), BoardSquare.new('B'), BoardSquare.new('1')]
    ]

    @cleared_squares = 0
    @length = 9
    @width = 9
    @amount_square_to_win = 71
    # El atributo anterior es 71 ya que son 81 cuadrados y 10 bombas.
    super()
  end

  def count_clear_square
    @cleared_squares += 1
  end

  def check_if_valid_coordinate(label, value)
    if label == 'x'
      if (@width > value) && (value >= 0)
        true
      else
        false
      end

    elsif label == 'y'
      if (@length > value) && (value >= 0)
        true
      else
        false
      end
    else
      false
    end
  end

  def unlock_square(y, x)
    @map[y][x].make_visible
    # Cada vez q se hace visible, se suma un cuadrado despejado
    count_clear_square
    if @map[y][x].item == 'B'
      # pierde
      'game over'
    else
      neighbors = get_neighbors(y, x)
      if neighbors != []
        neighbors.each do |neighbor|
          if @map[neighbor[0]][neighbor[1]].item_view == '?'
            if @map[y][x].item == '0'
              unlock_square(neighbor[0], neighbor[1])
              return true
            end
          end
        end
      end
      #checkeo de victoria
      if @cleared_squares == 71
        'game winner'
      end
    end
  end

  def get_neighbors(y, x)
    neighbors = []

    if y >= 1
      neighbors.push([y - 1, x])
      neighbors.push([y - 1, x - 1]) if x >= 1
      neighbors.push([y - 1, x + 1]) if x < @width - 1
    end

    if y < @length - 1
      neighbors.push([y + 1, x])
      neighbors.push([y + 1, x - 1]) if x >= 1
      neighbors.push([y + 1, x + 1]) if x < @width - 1
    end

    neighbors.push([y, x - 1]) if x >= 1
    neighbors.push([y, x + 1]) if x < @width - 1
    neighbors
  end

  def flag_square(y, x)
    @map[y][x].flag
    true
  end

  def uncheck_square(y, x)
    @map[y][x].flag
    true
  end
  
end
