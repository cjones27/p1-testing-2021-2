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

        @boardsquare.flag()
        assert_equal(false, @boardsquare.flagged)
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