# frozen_string_literal: true

require 'json'
require_relative 'game'
require_relative 'save_game'
require_relative 'ragdoll_print'
require_relative 'ragdoll'

game = Game.new
game.start_game
