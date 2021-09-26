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
    @controller.flag_square(0, 0)
    assert_equal(true, @model.map[0][0].flagged)

    # unflag
    @controller.flag_square(0, 0)
    assert_equal(false, @model.map[0][0].flagged)
  end
end
