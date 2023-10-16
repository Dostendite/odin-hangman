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
    system 'clear'
    print_main_menu
    fetch_menu_choice
  end

  def play_game
    # Get user input

    # Remember that the ragdoll print method
    # will print the amount of lives left
  end

  private

  def print_main_menu
    puts "\n|------- HANGMAN GAME -------|"
    puts '|------- 1. New  game  ------|'
    puts '|------- 2. Load game -------|'
    puts
    print 'New game [1] | Load game [2]: '
  end

  # print out all the game elements
  def print_game
    system 'clear'
    @ragdoll.print_ragdoll
    print_secret_word
    # -> the letters already guessed (after the word)
  end

  def print_secret_word
    # iterate through the letters in the word
    # if they are in @right_guesses, show them
    # else,
  end

  def make_guess
    fetch_letter_guess
    # puts "Letters already guessed: #{letters_guessed}"

    # if the guess is correct, run update_guess
    # else, @ragdoll.lose_life
  end

  def pick_secret_word
    words_file = File.open('words.txt')
    word_list = words_file.readlines.map(&:chomp)

    word_list.each do |word|
      word_list.delete(word) if word.length < 5 || word.length > 12
    end

    @secret_word = word_list.sample
  end

  def fetch_menu_choice
    loop do
      choice = gets.chomp

      if choice == '1'
        create_save
        break
      elsif choice == '2'
        load_save
        break
      else
        print 'Please enter 1 or 2: '
      end
    end
  end

  def fetch_letter_guess
    puts 'Enter letter to guess: '

    loop do
      guess = gets.chomp

      # also account for characters that have already been tried
      break if ('a'..'z').include?(guess.downcase)

      puts 'Please enter a valid letter (a-z): '
    end
  end

  # dummy functions
  def create_save
    puts 'Creating save..'
  end

  def load_save
    puts 'Loading save...'
  end
end

Game.new.start_game
