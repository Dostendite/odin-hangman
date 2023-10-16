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
    # @save_id = create_save
  end

  def start_game
    system 'clear'
    print_main_menu
    fetch_menu_choice
  end

  def play_game
    game_status = game_over_check

    while game_status == 'continue'
      print_game
      make_guess

      game_status = game_over_check
    end

    end_game(game_status)
  end

  private

  def end_game(game_status)
    if game_status == 'victory'
      print_game
      puts 'You win!'
    else
      print_game
      puts 'You lose!'
    end

    # delete_save
  end

  def game_over_check
    if @secret_word.chars.all? { |letter| @right_guesses.include?(letter) }
      return 'victory'
    elsif @ragdoll.lives_left < 1
      return 'defeat'
    end
    return 'continue'
  end

  def print_main_menu
    puts '         HANGMAN GAME         '
    puts '       [ 1. New  game ]       '
    puts '       [ 2. Load game ]       '
    puts
    print 'New game [1] | Load game [2]: '
  end

  def print_game
    system 'clear'
    @ragdoll.print_ragdoll(@ragdoll.lives_left)
    print_secret_word

    print_guesses_made
  end

  def print_secret_word
    secret_word_print = []

    @secret_word.each_char do |letter|
      if @right_guesses.include?(letter)
        secret_word_print.push(letter)
      else
        secret_word_print.push('_')
      end
      secret_word_print.push(' ')
    end
    print 'Secret word: '
    print "#{secret_word_print.join} "
  end

  def make_guess
    letter_guess = fetch_letter_guess

    if @secret_word.include?(letter_guess)
      puts 'You guessed right!'
      @right_guesses.push(letter_guess)
    else
      puts 'You guessed wrong!'
      @wrong_guesses.push(letter_guess)
      @ragdoll.lose_life
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
        play_game
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
    print 'Enter guess: '
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

  def print_guesses_made
    guesses_made = (@right_guesses + @wrong_guesses).sort
    puts "Guesses made: #{guesses_made.join(', ')}"
  end

  # dummy functions for save_game module
  def scan_saves; end

  def create_save; end

  def load_save; end

  def delete_save; end
end

Game.new.start_game
