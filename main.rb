# frozen_string_literal: true

# Main game file

# When a new game is started, your script should load in the
# dictionary and randomly select a word between 5 and 12
# characters long for the secret word.

# Main game class w/ main menu
class Game
  def initialize
    @secret_word = ''
    @letters_guessed = []
    @letters_tried = []
    @ragdoll = Ragdoll.new
  end
  # Word input is case insensitive

  def start_game
    # Show main menu and
    # ask player if they want to
    # play a new game or load a save
  end

  def play_game
    # Get user input

    # Interact with the ragdoll class
    # only when the player fails, and print it
    # all the time
  end

  private

  def make_guess
    # If the guess is correct, run update_guess
    # else, @ragdoll.lose_life
  end
end

# Ragdoll class for hangman
class Ragdoll
  attr_reader :lives

  def initialize
    @lives = 10
  end

  def print_ragdoll
    # Prints the ragdoll based on the lives left
  end

  # Every time the player fails a guess,
  # the game object will inform this class
  # and run the lose_life method
  def lose_life
    @lives -= 1
    print_ragdoll
  end
end

# Saving / loading the game
module SaveGame; end
