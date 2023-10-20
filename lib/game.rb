# frozen_string_literal: true

require_relative 'save_game'
require_relative 'ragdoll_print'
require_relative 'ragdoll'

# Main game class w/ main menu
class Game
  include SaveGame

  def initialize
    @secret_word = pick_secret_word
    @right_guesses = []
    @wrong_guesses = []
    @ragdoll = Ragdoll.new
    @current_save_id = generate_save_id
  end

  def start_game
    print_main_menu
    prompt_menu_choice
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

  def prompt_menu_choice
    super
    play_game
  end

  def end_game(game_status)
    print_game
    delete_save(@current_save_id)
    if game_status == 'victory'
      puts 'You win!'
    else
      puts "You lose! The secret word was \"#{@secret_word}\""
    end
  end

  def game_over_check
    if @secret_word.chars.all? { |letter| @right_guesses.include?(letter) }
      return 'victory'
    elsif @ragdoll.lives_left < 1
      return 'defeat'
    end
    'continue'
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
    print "Secret word: #{secret_word_print.join}\n"
  end

  def make_guess
    letter_guess = prompt_letter_guess

    if letter_guess == 'save_game'
      delete_save(@current_save_id)
      create_save
      letter_guess = prompt_letter_guess
    end

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

  def prompt_letter_guess
    print 'Enter guess: '

    letter_guess = gets.chomp.downcase
    return 'save_game' if letter_guess == 'save_game'
    return 'load_game' if letter_guess == 'load_game'

    loop do
      if ('a'..'z').include?(letter_guess)
        if @right_guesses.include?(letter_guess) ||
           @wrong_guesses.include?(letter_guess)
          print 'Letter already attempted, pick another one: '
          letter_guess = gets.chomp.downcase
        else
          break
        end
      else
        print 'Please enter a letter [a-z]: '
        letter_guess = gets.chomp.downcase
      end
    end
    letter_guess[0].downcase
  end

  def print_guesses_made
    guesses_made = (@right_guesses + @wrong_guesses).sort
    puts "Guesses made: #{guesses_made.join(', ')}"
  end

  def create_save
    super(pack_data)
    puts 'Saved the game!'
  end

  def load_save
    unpacked_save = super
    unpacked_save.each do |key, val|
      instance_variable_set("@#{key}", val)
    end
    play_game
  end

  def print_instance_variables
    instance_variables.each do |var|
      value = instance_variable_get var
      puts "Instance variable #{var} | Value #{value}"
    end
  end
end
