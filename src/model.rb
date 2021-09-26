# frozen_string_literal: true

require_relative './observer/observable'
require 'matrix'

# BoardSquare
class BoardSquare
  attr_reader :item, :visible
  # Los siguientes reader son solo para acceder a los atributos al testear
  attr_reader :flagged

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

# BoardMap
class BoardMap
  attr_accessor :map

  def initialize
    @map = []

    push_map_part1
    push_map_part2
    push_map_part3
    push_map_part4
    push_map_part5
    push_map_part6
    push_map_part7
    push_map_part8
    push_map_part9
  end

  def push_map_part1
    @map.push([BoardSquare.new('B'), BoardSquare.new('3'), BoardSquare.new('B'),
               BoardSquare.new('1'), BoardSquare.new('0'), BoardSquare.new('0'),
               BoardSquare.new('0'), BoardSquare.new('0'), BoardSquare.new('0')])
  end

  def push_map_part2
    @map.push([BoardSquare.new('2'), BoardSquare.new('B'), BoardSquare.new('2'),
               BoardSquare.new('1'), BoardSquare.new('0'), BoardSquare.new('0'),
               BoardSquare.new('1'), BoardSquare.new('1'), BoardSquare.new('1')])
  end

  def push_map_part3
    @map.push([BoardSquare.new('1'), BoardSquare.new('1'), BoardSquare.new('1'),
               BoardSquare.new('0'), BoardSquare.new('0'), BoardSquare.new('0'),
               BoardSquare.new('1'), BoardSquare.new('B'), BoardSquare.new('1')])
  end

  def push_map_part4
    @map.push([BoardSquare.new('0'), BoardSquare.new('0'), BoardSquare.new('0'),
               BoardSquare.new('0'), BoardSquare.new('0'), BoardSquare.new('0'),
               BoardSquare.new('1'), BoardSquare.new('1'), BoardSquare.new('1')])
  end

  def push_map_part5
    @map.push([BoardSquare.new('0'), BoardSquare.new('0'), BoardSquare.new('0'),
               BoardSquare.new('1'), BoardSquare.new('1'), BoardSquare.new('2'),
               BoardSquare.new('2'), BoardSquare.new('2'), BoardSquare.new('1')])
  end

  def push_map_part6
    @map.push([BoardSquare.new('0'), BoardSquare.new('0'), BoardSquare.new('0'),
               BoardSquare.new('1'), BoardSquare.new('B'), BoardSquare.new('3'),
               BoardSquare.new('B'), BoardSquare.new('B'), BoardSquare.new('1')])
  end

  def push_map_part7
    @map.push([BoardSquare.new('0'), BoardSquare.new('0'), BoardSquare.new('0'),
               BoardSquare.new('1'), BoardSquare.new('1'), BoardSquare.new('3'),
               BoardSquare.new('B'), BoardSquare.new('3'), BoardSquare.new('1')])
  end

  def push_map_part8
    @map.push([BoardSquare.new('0'), BoardSquare.new('0'), BoardSquare.new('0'),
               BoardSquare.new('1'), BoardSquare.new('1'), BoardSquare.new('2'),
               BoardSquare.new('2'), BoardSquare.new('2'), BoardSquare.new('1')])
  end

  def push_map_part9
    @map.push([BoardSquare.new('0'), BoardSquare.new('0'), BoardSquare.new('0'),
               BoardSquare.new('1'), BoardSquare.new('B'), BoardSquare.new('1'),
               BoardSquare.new('1'), BoardSquare.new('B'), BoardSquare.new('1')])
  end
end

# BoardModel
class BoardModel < Observable
  attr_accessor :map, :cleared_squares

  # Siguientes reader son para usar en los tests

  attr_reader :length, :width

  def initialize
    @mapclass = BoardMap.new
    @map = @mapclass.map

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
    case label
    when 'x'
      check_x_valid_coordinate(value)
    when 'y'
      check_y_valid_coordinate(value)
    else
      false
    end
  end

  def check_x_valid_coordinate(value)
    if only_int_in_str(value) && (@width > value.to_i) && (value.to_i >= 0)
      true
    else
      false
    end
  end

  def check_y_valid_coordinate(value)
    if only_int_in_str(value) && (@length > value.to_i) && (value.to_i >= 0)
      true
    else
      false
    end
  end

  def unlock_square(y_position, x_position)
    check_unlock = unlock_selected_square(y_position, x_position)
    return check_unlock if check_unlock != 'next'

    # return 'game over' if unlock_selected_square(y_position, x_position) == 'game over'

    # return 'square already unlocked' if @map[y_position][x_position].item_view == '?'

    neighbors = get_neighbors(y_position, x_position)
    if neighbors != []
      neighbors.each do |neighbor|
        next unless @map[neighbor[0]][neighbor[1]].item_view == '?'

        unlock_square(neighbor[0], neighbor[1]) if @map[y_position][x_position].item == '0'
      end
    end
    # checkeo de victoria
    'game winner' if @cleared_squares == 71
  end

  def unlock_selected_square(y_position, x_position)
    return 'square already unlocked' if @map[y_position][x_position].item_view != '?'

    @map[y_position][x_position].make_visible
    count_clear_square
    return 'game over' if @map[y_position][x_position].item == 'B'

    'next'
  end

  def get_neighbors(y_position, x_position)
    neighbors = []
    neighbors = check_lower_border_case(neighbors, x_position, y_position)
    neighbors = check_upper_border_case(neighbors, x_position, y_position)

    neighbors.push([y_position, x_position - 1]) if x_position >= 1
    neighbors.push([y_position, x_position + 1]) if x_position < @width - 1
    neighbors
  end

  def check_lower_border_case(neighbors, x_position, y_position)
    if y_position >= 1
      neighbors.push([y_position - 1, x_position])
      neighbors.push([y_position - 1, x_position - 1]) if x_position >= 1
      neighbors.push([y_position - 1, x_position + 1]) if x_position < @width - 1
    end

    neighbors
  end

  def check_upper_border_case(neighbors, x_position, y_position)
    if y_position < @length - 1
      neighbors.push([y_position + 1, x_position])
      neighbors.push([y_position + 1, x_position - 1]) if x_position >= 1
      neighbors.push([y_position + 1, x_position + 1]) if x_position < @width - 1
    end

    neighbors
  end

  # def flag_square(y_position, x_position)
  #   @map[y_position][x_position].flag
  #   true
  # end

  # def uncheck_square(y_position, x_position)
  #   @map[y_position][x_position].flag
  #   true
  # end

  def flag_unflag_square(y_position, x_position)
    return 'square already unlocked' if @map[y_position][x_position].visible

    @map[y_position][x_position].flag
    true
  end

  def only_int_in_str(str)
    if str =~ /[a-zA-Z!@£$%^&*()_{}"|?><~+“‘«æ÷≥≤«¡≠–`±’”Æ»Ú˘¿¯]/ or str.to_s.match?(" ")
      false
    else 
      true
    end
  end
end
