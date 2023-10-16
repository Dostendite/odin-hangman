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

  def start_game
    system 'clear'
    print_main_menu
    fetch_menu_choice
  end

  def play_game
    loop do
      print_game
      make_guess

      check_game_over
    end
  end

  private

  def print_main_menu
    puts '         HANGMAN GAME         '
    puts '       [ 1. New  game ]       '
    puts '       [ 2. Load game ]       '
    puts
    print 'New game [1] | Load game [2]: '
  end

  # print out all the game elements
  def print_game
    system 'clear'
    @ragdoll.print_ragdoll
    print_secret_word
    puts "Letters already guessed: #{@right_guesses}" if @right_guesses.length > 0
  end

  def print_secret_word
    # iterate through the letters in the word
    # if they are in @right_guesses, show them
    # else,
  end

  def make_guess
    letter_guess = fetch_letter_guess

    if @secret_word.include?(letter_guess)
      puts 'You guessed right!'
      @right_guesses.push(letter_guess)
    else
      puts 'You guessed wrong!'
      @wrong_guesses.push(letter_guess)
      ragdoll.lose_life
    end
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
    print 'Enter letter to guess: '
    letter_guess = ''

    loop do
      letter_guess = gets.chomp.downcase

      if ('a'..'z').include?(letter_guess)
        if @right_guesses.include?(letter_guess) ||
           @wrong_guesses.include?(letter_guess)
          print 'Letter already attempted, pick another one: '
        else
          break
        end
      else
        print 'Please enter a letter [a-z]: '
      end
    end

    letter_guess.downcase
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
