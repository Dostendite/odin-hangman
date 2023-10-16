# frozen_string_literal: true

require_relative 'ragdoll_print'
require_relative 'ragdoll'

# Main game class w/ main menu
class Game
  def initialize
    @secret_word = pick_secret_word
    @right_guesses = []
    @wrong_guesses = []
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

    # Remember that the ragdoll print method
    # will print the amount of lives left
  end

  # private

  # print out all the game elements
  def print_game
    system 'clear'
    @ragdoll.print_ragdoll
    print_secret_word
    # -> the letters already guessed (after the word)
  end

  def print_secret_word
    # prints the secret word but
    # replacing letters not yet
    # discovered with an underscore
  end

  def make_guess
    # puts "Letters already guessed: #{letters_guessed}"
    puts 'Enter letter to guess: '

    loop do
      guess = gets.chomp

      break if ('a'..'z').include?(guess.downcase)

      puts 'Please enter a valid letter (a-z): '
    end

    # if the guess is correct, run update_guess
    # else, @ragdoll.lose_life
  end

  def pick_secret_word
    words_file = File.open('words.txt')
    word_list = words_file.readlines.map(&:chomp)

    word_list.each do |word|
      word_list.delete(word) if word.length < 5 || word.length > 12
    end

    secret_word = word_list.sample
    puts "The secret word is #{secret_word}"
  end
end

Game.new.make_guess