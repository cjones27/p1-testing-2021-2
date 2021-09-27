# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../src/model'
require 'test/unit'

class BoardMapTest < Test::Unit::TestCase
  def setup
    @mapclass = BoardMap.new
    @mapclass.map = []
  end

  def test_populate
    @mapclass.create_row(%w[B 3 B 1 0 0 0 0 0])
    assert_equal('B', @mapclass.map[0][0].item)
    assert_equal(false, @mapclass.map[0][0].visible)
    assert_equal(false, @mapclass.map[0][0].flagged)
  end
end
