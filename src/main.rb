# frozen_string_literal: true

require 'matrix'

require_relative './model'
require_relative './controller'
require_relative './view'

model = BoardModel.new
view = BoardView.new
# model.add_observer(view)
controller = BoardController.new(model, view)
# controller.display_board
controller.main_menu
