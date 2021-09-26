# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../src/model'
require 'test/unit'

class BoardModelCoordinatesTest < Test::Unit::TestCase
  def setup
    @mapclass = BoardMap.new
  end

  def test_populate
    @mapclass.map = []
    @mapclass.populate_map
    assert_equal('B', @mapclass.map[0][0].item)
    assert_equal('?', @mapclass.map[0][0].item_view)
    assert_equal(false, @mapclass.map[0][0].flagged)
  end
end
