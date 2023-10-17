# frozen_string_literal: true

require 'json'
require_relative 'ragdoll'

# Module allows for file saving & loading
module SaveGame
  SAVES_DIRECTORY = './/saves/'

  def print_introduction
    system 'clear'
    puts 'Welcome to my Hangman game, I hope you will enjoy it!'
    puts 'Remember that you can save the game at ANY point in time'
    puts 'with the command \'save_game\', and you can load any game'
    puts 'with \'load_game\'!'
    puts
    print 'Press any key to start the game... '

    gets
  end

  def print_main_menu
    print_introduction
    system 'clear'
    puts '         HANGMAN GAME         '
    puts '       [ 1. New  game ]       '
    puts '       [ 2. Load game ]       '
    puts
    print 'New game [1] | Load game [2]: '
  end

  def print_saves_menu
    save_list = scan_saves
    system 'clear'
    puts '          SAVE MENU           '
    save_list.each do |save|
      puts "        [ Save No. #{save} ]      "
    end
  end

  def scan_saves(mode='default')
    # non default mode returns the
    # raw file name for load_saves to use
    saves = Dir.glob("#{SAVES_DIRECTORY}*")
    save_list = []

    if mode == 'default'
      saves.each do |save|
        save_id = save.match(/\d+/)
        save_list << save_id.to_s
      end
    else
      saves.each { |save| save_list << save }
    end
    save_list
  end

  def create_save(save_object)
    save_list = scan_saves
    new_save_name = "hangman_save_#{save_list.size + 1}"
    new_save_file = File.open("#{SAVES_DIRECTORY}/#{new_save_name}", 'w+')
    new_save_file.write(save_object)
    new_save_file.close
  end

  def load_save
    save_id = prompt_save_to_load

    save_list = scan_saves('load')
    save_to_load = File.open(save_list[save_id.to_i - 1], 'r')
    save_data = save_to_load.read
    Marshal.load(save_data)
  end

  # def delete_save(save_id)
  # end

  def pack_data
    save_object = {}
    instance_variables.each do |var|
      var_str = var.to_s
      var_name = var_str[1..var_str.size]
      var_value = instance_variable_get var
      save_object[var_name] = var_value
    end
    Marshal.dump(save_object)
  end

  private

  def prompt_save_to_load
    print_saves_menu

    print 'Enter the ID of save to load: '

    save_list = scan_saves('load')
    id_to_load = gets.chomp.to_i

    unless (1..save_list.size).include?(id_to_load)
      until (1..save_list.size).include?(id_to_load)
      print 'Please enter a valid save number: '
      id_to_load = gets.chomp.to_i
      end
    end
  end

  def prompt_menu_choice
    loop do
      choice = gets.chomp
      if choice == '1'
        create_save
        return choice
      elsif choice == '2'
        load_save
      else
        print 'Please enter 1 or 2: '
      end
    end
  end
end

# Dummy game class for save testing
class DummyGame
  include SaveGame

  attr_reader :secret_word, :right_guesses, :wrong_guesses, :ragdoll, :save_id

  def initialize
    @secret_word = nil
    @right_guesses = nil
    @wrong_guesses = nil
    @ragdoll = Ragdoll.new
    @save_id = nil
  end
end
