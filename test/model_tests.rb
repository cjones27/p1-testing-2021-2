# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../src/model'
require 'test/unit'

class BoardModelCoordinatesTest < Test::Unit::TestCase
  def setup
    @boardmodel = BoardModel.new
  end

  def test_count_clear_square
    @boardmodel.count_clear_square
    assert_equal(@boardmodel.cleared_squares, 1)
  end

  def test_check_if_valid_coordinate_case_x_under_range
    x = -1
    boolean = @boardmodel.check_if_valid_coordinate('x', x)
    assert(!boolean)
  end

  def test_check_if_valid_coordinate_case_x_over_range
    x = 20
    boolean = @boardmodel.check_if_valid_coordinate('x', x)
    assert(!boolean)
  end

  def test_check_if_valid_coordinate_case_x_valid
    x = rand(@boardmodel.width)
    boolean = @boardmodel.check_if_valid_coordinate('x', x)
    assert(boolean)
  end

  def test_check_if_valid_coordinate_case_label_x_invalid
    x = rand(@boardmodel.length)
    boolean = @boardmodel.check_if_valid_coordinate('w', x)
    assert(!boolean)
  end

  def test_check_if_valid_coordinate_case_x_letter_in_input
    x = '1a'
    assert(!@boardmodel.check_if_valid_coordinate('x', x))
  end

  def test_check_if_valid_coordinate_case_x_special_char_in_input
    x = '%1$%^'
    assert(!@boardmodel.check_if_valid_coordinate('x', x))
  end

  def test_check_if_valid_coordinate_case_x_only_letters_in_input
    x = 'asdadsasd'
    assert(!@boardmodel.check_if_valid_coordinate('x', x))
  end

  def test_check_if_valid_coordinate_case_y_under_range
    y = -10
    boolean = @boardmodel.check_if_valid_coordinate('y', y)
    assert(!boolean)
  end

  def test_check_if_valid_coordinate_case_y_over_range
    y = 13
    boolean = @boardmodel.check_if_valid_coordinate('y', y)
    assert(!boolean)
  end

  def test_check_if_valid_coordinate_case_y_valid
    y = rand(@boardmodel.length)
    boolean = @boardmodel.check_if_valid_coordinate('y', y)
    assert(boolean)
  end

  def test_check_if_valid_coordinate_case_label_y_invalid
    y = rand(@boardmodel.length)
    boolean = @boardmodel.check_if_valid_coordinate('z', y)
    assert(!boolean)
  end

  def test_check_if_valid_coordinate_case_y_letter_in_input
    y = '1a'
    assert(!@boardmodel.check_if_valid_coordinate('y', y))
  end

  def test_check_if_valid_coordinate_case_y_special_char_in_input
    y = '%1$%^'
    assert(!@boardmodel.check_if_valid_coordinate('y', y))
  end

  def test_check_if_valid_coordinate_case_y_only_letters_in_input
    y = 'asdadsasd'
    assert(!@boardmodel.check_if_valid_coordinate('y', y))
  end
end

class BoardModelSquareTest < Test::Unit::TestCase
  def setup
    @boardmodel = BoardModel.new
  end

  # def test_unlock_square_case_game_over
  #   # ya que la casilla 0,0 tiene bomba, la usaremos para el test
  #   x = 0
  #   y = 0
  #   string = @boardmodel.unlock_square(y, x)
  #   assert_equal(string, 'game over')
  # end

  # def test_unlock_square_case_winner
  #   # ya que la casilla 1,0 no tiene bomba, la usaremos para desbloquear la ultima
  #   # casilla restante
  #   x = 1
  #   y = 0
  #   # seteamos en 70 los cuadrados descubiertos
  #   @boardmodel.cleared_squares = 70
  #   string = @boardmodel.unlock_square(y, x)
  #   assert_equal(string, 'game winner')
  # end

  def test_flag_square_b
    boolean = @boardmodel.flag_unflag_square(2, 0)
    assert(boolean)
  end

  def test_uncheck_square_b
    boolean = @boardmodel.flag_unflag_square(2, 0)
    assert(boolean)
  end

  def test_flag_square_zero
    boolean = @boardmodel.flag_unflag_square(3, 0)
    assert(boolean)
  end

  def test_uncheck_square_zero
    boolean = @boardmodel.flag_unflag_square(3, 0)
    assert(boolean)
  end

  def test_flag_square_number
    boolean = @boardmodel.flag_unflag_square(1, 0)
    assert(boolean)
  end

  def test_uncheck_square_number
    boolean = @boardmodel.flag_unflag_square(1, 0)
    assert(boolean)
  end
end

class BoardModelNeighborsTest < Test::Unit::TestCase
  def setup
    @boardmodel = BoardModel.new
  end

  def test_get_neighbors_x0_y0
    # este par es el caso extremo de la casilla localizada en la esquina izquierda
    # de arriba del tablero
    y = 0
    x = 0
    neighbors = @boardmodel.get_neighbors(y, x)
    neighbors_expected = [[1, 0], [1, 1], [0, 1]]
    set_neighbors = neighbors.to_set
    set_neighbors_expected = neighbors_expected.to_set
    assert(set_neighbors.difference(set_neighbors_expected).none?)
    assert_equal(neighbors.length, neighbors_expected.length)
  end

  def test_get_neighbors_x2_y0
    # este par es el caso extremo donde la casilla esta en la primera fila
    # y en el interior de esta (no en los extremos) (5 vecinos en total)
    y = 0
    x = 2
    neighbors = @boardmodel.get_neighbors(y, x)
    neighbors_expected = [[0, 1], [0, 3], [1, 3], [1, 2], [1, 1]]
    set_neighbors = neighbors.to_set
    set_neighbors_expected = neighbors_expected.to_set
    assert(set_neighbors.difference(set_neighbors_expected).none?)
    assert_equal(neighbors.length, neighbors_expected.length)
  end

  def test_get_neighbors_x8_y0
    # este par es el caso extremo de la casilla localizada en la esquina derecha
    # de arriba del tablero (3 vecinos en total)
    y = 0
    x = 8
    neighbors = @boardmodel.get_neighbors(y, x)
    neighbors_expected = [[0, 7], [1, 7], [1, 8]]
    set_neighbors = neighbors.to_set
    set_neighbors_expected = neighbors_expected.to_set
    assert(set_neighbors.difference(set_neighbors_expected).none?)
    assert_equal(neighbors.length, neighbors_expected.length)
  end

  def test_get_neighbors_x3_y3
    # este par es el caso de aquella casilla con 8 vecinos en total
    y = 3
    x = 3
    neighbors = @boardmodel.get_neighbors(y, x)
    neighbors_expected = [[3, 2], [3, 4], [2, 2], [2, 3], [2, 4], [4, 2], [4, 3], [4, 4]]
    set_neighbors = neighbors.to_set
    set_neighbors_expected = neighbors_expected.to_set
    assert(set_neighbors.difference(set_neighbors_expected).none?)
    assert_equal(neighbors.length, neighbors_expected.length)
  end

  def test_get_neighbors_x0_y8
    # este par es el caso de aquella casilla localizada en el extremo
    # izquierdo de abajo del tablero (3 vecinos en total)
    y = 8
    x = 0
    neighbors = @boardmodel.get_neighbors(y, x)
    neighbors_expected = [[7, 0], [7, 1], [8, 1]]
    set_neighbors = neighbors.to_set
    set_neighbors_expected = neighbors_expected.to_set
    assert(set_neighbors.difference(set_neighbors_expected).none?)
    assert_equal(neighbors.length, neighbors_expected.length)
  end

  def test_get_neighbors_x8_y8
    # este par es el caso de aquella casilla localizada en el extremo
    # derecho de abajo del tablero (3 vecinos en total)
    y = 8
    x = 8
    neighbors = @boardmodel.get_neighbors(y, x)
    neighbors_expected = [[7, 8], [7, 7], [8, 7]]
    set_neighbors = neighbors.to_set
    set_neighbors_expected = neighbors_expected.to_set
    assert(set_neighbors.difference(set_neighbors_expected).none?)
    assert_equal(neighbors.length, neighbors_expected.length)
  end

  def test_get_neighbors_x5_y8
    # este par es el caso extremo donde la casilla esta en la ultima fila
    # y en el interior de esta (no en los extremos) (5 vecinos en total)
    y = 8
    x = 5
    neighbors = @boardmodel.get_neighbors(y, x)
    neighbors_expected = [[8, 4], [8, 6], [7, 4], [7, 5], [7, 6]]
    set_neighbors = neighbors.to_set
    set_neighbors_expected = neighbors_expected.to_set
    assert(set_neighbors.difference(set_neighbors_expected).none?)
    assert_equal(neighbors.length, neighbors_expected.length)
  end

  def test_get_neighbors_x0_y5
    # este par es el caso extremo donde la casilla esta en la primera columna
    # y en el interior de esta (no en los extremos) (5 vecinos en total)
    y = 5
    x = 0
    neighbors = @boardmodel.get_neighbors(y, x)
    neighbors_expected = [[5, 1], [4, 0], [4, 1], [6, 0], [6, 1]]
    set_neighbors = neighbors.to_set
    set_neighbors_expected = neighbors_expected.to_set
    assert(set_neighbors.difference(set_neighbors_expected).none?)
    assert_equal(neighbors.length, neighbors_expected.length)
  end

  def test_get_neighbors_x8_y5
    # este par es el caso extremo donde la casilla esta en la ultima columna
    # y en el interior de esta (no en los extremos) (5 vecinos en total)
    y = 5
    x = 8
    neighbors = @boardmodel.get_neighbors(y, x)
    neighbors_expected = [[5, 7], [4, 7], [4, 8], [6, 7], [6, 8]]
    set_neighbors = neighbors.to_set
    set_neighbors_expected = neighbors_expected.to_set
    assert(set_neighbors.difference(set_neighbors_expected).none?)
    assert_equal(neighbors.length, neighbors_expected.length)
  end
end
