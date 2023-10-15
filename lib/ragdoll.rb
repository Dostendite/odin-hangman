# frozen_string_literal: true

require_relative 'ragdoll_print'

# Hangman ragdoll
class Ragdoll
  include RagdollPrint
  attr_reader :lives

  def initialize
    @lives_left = 10
  end

  # this method will be run by the game object
  def lose_life
    @lives_left -= 1
    print_ragdoll(@lives_left)
  end
end

ragdoll = Ragdoll.new

ragdoll.print_ragdoll(10)

puts "Building ragdoll..."

10.times do
  ragdoll.lose_life
  sleep 0.5
end
