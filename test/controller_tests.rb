# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../src/model'
require_relative '../src/controller'
require_relative '../src/view'
require 'test/unit'

class BoardControllerTest < Test::Unit::TestCase
  def setup
    # inicializamos
    @model = BoardModel.new
    @view = BoardView.new
    @controller = BoardController.new(@model, @view)
  end

  def test_flag_square
    # flag
    @controller.flag_unflag_square('0', '0')
    assert_equal(true, @model.map[0][0].flagged)

    # unflag
    @controller.flag_unflag_square('0', '0')
    assert_equal(false, @model.map[0][0].flagged)
  end

  # def test_receive_input
  #   result = @controller.receive_input
  #   assert_true(result[0].instance_of?(String))
  #   assert_true(result[1].instance_of?(String))
  # end

  # def test_unlock_square_correctly_case
  #   @controller.unlock_square('2', '2')
  #   item = @model.map[2][2].item_view
  #   assert_not_equal('?', item)
  # end
end
