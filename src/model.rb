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

  def assign_item(item)
    @item = item
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
  attr_reader :length, :width

  def initialize
    @length = 8
    @width = 8
    @string_map = Array.new(@length) { Array.new(@width, 0) }
    @map = []
    @bomb_count = 10
    create_map
  end

  def create_map
    create_bomb_coords
    fill_numbers
    populate_map
  end

  def create_bomb_coords
    bomb_coords = []

    while bomb_coords.length != @bomb_count
      y = rand(@length)
      x = rand(@width)
      next if bomb_coords.include? [y, x]

      bomb_coords.push([y, x])
    end

    bomb_coords.each do |bomb|
      @string_map[bomb[0]][bomb[1]] = 'B'
    end
  end

  def fill_numbers
    (0..(@length - 1)).each do |y|
      (0..(@width - 1)).each do |x|
        next if @string_map[y][x] == 'B'

        @string_map[y][x] = count_bombs(y, x).to_s
      end
    end
  end

  def count_bombs(y_position, x_position)
    count = 0
    count += count_upper_bombs(y_position, x_position) if y_position >= 1
    count += count_lower_bombs(y_position, x_position) if y_position < @length - 1
    count += count_side_bombs(y_position, x_position)
    count
  end

  def count_side_bombs(y_position, x_position)
    count = 0
    count += 1 if x_position >= 1 && @string_map[y_position][x_position - 1] == 'B'
    count += 1 if x_position < @width - 1 && @string_map[y_position][x_position + 1] == 'B'
    count
  end

  def count_upper_bombs(y_position, x_position)
    count = 0
    count += 1 if @string_map[y_position - 1][x_position] == 'B'
    count += 1 if x_position >= 1 && @string_map[y_position - 1][x_position - 1] == 'B'
    count += 1 if x_position < @width - 1 && @string_map[y_position - 1][x_position + 1] == 'B'
    count
  end

  def count_lower_bombs(y_position, x_position)
    count = 0
    count += 1 if @string_map[y_position + 1][x_position] == 'B'
    count += 1 if x_position >= 1 && @string_map[y_position + 1][x_position - 1] == 'B'
    count += 1 if x_position < @width - 1 && @string_map[y_position + 1][x_position + 1] == 'B'
    count
  end

  def populate_map
    @string_map.each do |row|
      create_row(row)
    end
  end

  def create_row(items_in_row)
    row = []
    items_in_row.each do |item|
      row.push(BoardSquare.new(item))
    end
    @map.push(row)
  end
end

# BoardModel
class BoardModel < Observable
  attr_accessor :map, :cleared_squares, :length, :width

  # Siguientes reader son para usar en los tests

  def initialize
    @mapclass = BoardMap.new
    @map = @mapclass.map

    @cleared_squares = 0
    @length = @mapclass.length
    @width = @mapclass.width
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

    unlock_square_neighbors(y_position, x_position)
    # checkeo de victoria
    'game winner' if @cleared_squares == 71
  end

  def unlock_square_neighbors(y_position, x_position)
    neighbors = get_neighbors(y_position, x_position)
    return if neighbors == []

    neighbors.each do |neighbor|
      next unless @map[neighbor[0]][neighbor[1]].item_view == '?'

      unlock_square(neighbor[0], neighbor[1]) if @map[y_position][x_position].item == '0'
    end
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

  def flag_unflag_square(y_position, x_position)
    return 'square already unlocked' if @map[y_position][x_position].visible

    @map[y_position][x_position].flag
    true
  end

  def only_int_in_str(str)
    if str =~ (/[a-zA-Z!@£$%^&*()_{}"|?><~+“‘«æ÷≥≤«¡≠–`±’”Æ»Ú˘¿¯]/) || str.to_s.match?(' ')
      false
    else
      true
    end
  end
end
