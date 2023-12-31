# frozen_string_literal: true

require_relative 'ragdoll_print'

# Hangman ragdoll
class Ragdoll
  include RagdollPrint
  attr_reader :lives_left

  def initialize
    @lives_left = 10
  end

  def lose_life
    @lives_left -= 1
  end
end
