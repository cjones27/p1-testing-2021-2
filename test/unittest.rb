# frozen_string_literal: true
require_relative 'test_helper'
require_relative '../src/model'
require 'test/unit'




class BoardSquareTest < Test::Unit::TestCase

    def setup
        #inicializamos
        @boardsquare = BoardSquare.new('B')
    end

    def test_flag
        @boardsquare.flag()

        assert_equal(true, @boardsquare.flagged)
    end

    def test_make_visible
        @boardsquare.make_visible()

        assert_equal(true, @boardsquare.visible)
        assert_equal(false, @boardsquare.flagged)
    end

    def test_item_view_1
        result = @boardsquare.item_view()

        assert_equal('?', result)
    end

    def test_item_view_2
        @boardsquare.flag
        result = @boardsquare.item_view()

        assert_equal('F', result)
    end

    def test_item_view_3
        @boardsquare.make_visible
        result = @boardsquare.item_view()

        assert_equal(@boardsquare.item, result)
    end
end

class BoardModelTest < Test::Unit::TestCase
    def setup
        @boardmodel =  BoardModel.new()
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

    def test_unlock_square_case_game_over
        #ya que la casilla 0,0 tiene bomba, la usaremos para el test
        x = 0
        y = 0
        string = @boardmodel.unlock_square(y, x)
        assert_equal(string, 'game over')
    end

    def test_unlock_square_case_winner
        #ya que la casilla 1,0 no tiene bomba, la usaremos para desbloquear la última
        #casilla restante
        x = 1
        y = 0
        #seteamos en 70 los cuadrados descubiertos
        @boardmodel.cleared_squares = 70
        string = @boardmodel.unlock_square(y, x)
        assert_equal(string, 'game winner')
    end

    def test_flag_square_b
        boolean = @boardmodel.flag_square(2,0)
        assert(boolean)
    end 

    def test_uncheck_square_b
        boolean = @boardmodel.uncheck_square(2,0)
        assert(boolean)
    end 

    def test_flag_square_zero
        boolean = @boardmodel.flag_square(3,0)
        assert(boolean)
    end 

    def test_uncheck_square_zero
        boolean = @boardmodel.uncheck_square(3,0)
        assert(boolean)
    end 

    def test_flag_square_number
        boolean = @boardmodel.flag_square(1,0)
        assert(boolean)
    end 

    def test_uncheck_square_number
        boolean = @boardmodel.uncheck_square(1,0)
        assert(boolean)
    end 

    def test_get_neighbors_x_0_y_0
        #este par es el caso extremo de la casilla localizada en la esquina izquierda
        #de arriba del tablero
        y = 0
        x = 0
        neighbors = @boardmodel.get_neighbors(y, x)
        neighbors_expected = [[1,0], [1,1], [0,1]]
        set_neighbors = neighbors.to_set
        set_neighbors_expected = neighbors_expected.to_set
        assert(!set_neighbors.difference(set_neighbors_expected).any?)
        assert_equal(neighbors.length(), neighbors_expected.length())
    end

    def test_get_neighbors_x_2_y_0
        #este par es el caso extremo donde la casilla está en la primera fila
        # y en el interior de ésta (no en los extremos) (5 vecinos en total)
        y = 0
        x = 2
        neighbors = @boardmodel.get_neighbors(y, x)
        neighbors_expected = [[0,1], [0,3], [1,3], [1,2], [1,1]]
        set_neighbors = neighbors.to_set
        set_neighbors_expected = neighbors_expected.to_set
        assert(!set_neighbors.difference(set_neighbors_expected).any?)
        assert_equal(neighbors.length(), neighbors_expected.length())
    end

    def test_get_neighbors_x_8_y_0
        #este par es el caso extremo de la casilla localizada en la esquina derecha
        #de arriba del tablero (3 vecinos en total)
        y = 0
        x = 8
        neighbors = @boardmodel.get_neighbors(y, x)
        neighbors_expected = [[0,7], [1,7], [1,8]]
        set_neighbors = neighbors.to_set
        set_neighbors_expected = neighbors_expected.to_set
        assert(!set_neighbors.difference(set_neighbors_expected).any?)
        assert_equal(neighbors.length(), neighbors_expected.length())
    end

    def test_get_neighbors_x_3_y_3
        #este par es el caso de aquella casilla con 8 vecinos en total
        y = 3
        x = 3
        neighbors = @boardmodel.get_neighbors(y, x)
        neighbors_expected = [[3,2], [3,4], [2,2], [2,3], [2,4], [4,2],[4,3], [4,4]]
        set_neighbors = neighbors.to_set
        set_neighbors_expected = neighbors_expected.to_set
        assert(!set_neighbors.difference(set_neighbors_expected).any?)
        assert_equal(neighbors.length(), neighbors_expected.length())
    end

    def test_get_neighbors_x_0_y_8
        #este par es el caso de aquella casilla localizada en el extremo 
        #izquierdo de abajo del tablero (3 vecinos en total)
        y = 8
        x = 0
        neighbors = @boardmodel.get_neighbors(y, x)
        neighbors_expected = [[7,0], [7,1], [8,1]]
        set_neighbors = neighbors.to_set
        set_neighbors_expected = neighbors_expected.to_set
        assert(!set_neighbors.difference(set_neighbors_expected).any?)
        assert_equal(neighbors.length(), neighbors_expected.length())
    end

    def test_get_neighbors_x_8_y_8
        #este par es el caso de aquella casilla localizada en el extremo 
        #derecho de abajo del tablero (3 vecinos en total)
        y = 8
        x = 8
        neighbors = @boardmodel.get_neighbors(y, x)
        neighbors_expected = [[7,8], [7,7], [8,7]]
        set_neighbors = neighbors.to_set
        set_neighbors_expected = neighbors_expected.to_set
        assert(!set_neighbors.difference(set_neighbors_expected).any?)
        assert_equal(neighbors.length(), neighbors_expected.length())
    end

    def test_get_neighbors_x_5_y_8
        #este par es el caso extremo donde la casilla está en la última fila
        # y en el interior de ésta (no en los extremos) (5 vecinos en total)
        y = 8
        x = 5
        neighbors = @boardmodel.get_neighbors(y, x)
        neighbors_expected = [[8,4], [8,6], [7,4], [7,5], [7,6]]
        set_neighbors = neighbors.to_set
        set_neighbors_expected = neighbors_expected.to_set
        assert(!set_neighbors.difference(set_neighbors_expected).any?)
        assert_equal(neighbors.length(), neighbors_expected.length())
    end

    def test_get_neighbors_x_0_y_5
        #este par es el caso extremo donde la casilla está en la primera columna
        # y en el interior de ésta (no en los extremos) (5 vecinos en total)
        y = 5
        x = 0
        neighbors = @boardmodel.get_neighbors(y, x)
        neighbors_expected = [[5,1], [4,0], [4,1], [6,0], [6,1]]
        set_neighbors = neighbors.to_set
        set_neighbors_expected = neighbors_expected.to_set
        assert(!set_neighbors.difference(set_neighbors_expected).any?)
        assert_equal(neighbors.length(), neighbors_expected.length())
    end

    def test_get_neighbors_x_8_y_5
        #este par es el caso extremo donde la casilla está en la última columna
        # y en el interior de ésta (no en los extremos) (5 vecinos en total)
        y = 5
        x = 8
        neighbors = @boardmodel.get_neighbors(y, x)
        neighbors_expected = [[5,7], [4,7], [4,8], [6,7], [6,8]]
        set_neighbors = neighbors.to_set
        set_neighbors_expected = neighbors_expected.to_set
        assert(!set_neighbors.difference(set_neighbors_expected).any?)
        assert_equal(neighbors.length(), neighbors_expected.length())
    end

    def test_unlock_square_case_value_0
        # Ya que la casilla casilla seleccionada tiene valor 0 y es la primera
        # casilla en ser descubierta, se desbloquean automáticamente sus vecinos
        # ya que no tiene bombas en casillas colindantes (por tener valor 0).
        # Por lo anterior debería retornarse el true del método unlock_square cuando se 
        # entra a la condición de flujo asociada a este caso
        # Usaremos la casilla y = 3, x = 3 ya que tiene valor 0
        @boardmodel.cleared_squares = 0
        x = 3
        y = 3
        boolean = @boardmodel.unlock_square(y, x)
        assert(boolean)
    end
end