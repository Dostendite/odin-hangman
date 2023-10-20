# frozen_string_literal: true

require 'json'
require_relative 'ragdoll'

# Module allows for file saving & loading
module SaveGame
  SAVES_DIRECTORY = './/saves/'

  def print_introduction
    system 'clear'
    puts 'Welcome to my Hangman game, I hope you will enjoy it!'
    puts 'Remember that you can save the game at any point in time'
    puts 'with the command \'save_game\'.'
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
    save_list.each_with_index do |save, idx|
      puts "      [ #{idx + 1}. Save No. ##{save} ]"
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
    new_save_id = generate_save_id
    new_save_name = "hangman_save_#{new_save_id}"
    new_save_file = File.open("#{SAVES_DIRECTORY}/#{new_save_name}", 'w+')
    new_save_file.write(save_object)
    new_save_file.close
    new_save_name.match(/\d+/).to_s
  end

  def load_save
    id_to_load = prompt_save_to_load
    save_data = nil
    save_list = scan_saves('load')
    save_list.each do |save|
      save_id = save.match(/\d+/)
      if id_to_load == save_id.to_s
        save_to_load = File.open(save, 'r')
        save_data = save_to_load.read
        return Marshal.load(save_data)
      end
    end
  end

  def delete_save(id_to_delete)
    save_list = scan_saves('load')
    save_list.each do |save|
      save_id = save.match(/\d+/)
      if save_id.to_s == id_to_delete.to_s
        File.open(save, 'r') do |f|
          File.delete(f)
        end
      end
    end
  end

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

  def generate_save_id
    save_list = scan_saves
    save_list.size + 1
  end

  private

  def prompt_save_to_load
    print_saves_menu
    save_list = scan_saves

    print 'Enter the ID of save to load: '
    id_to_load = gets.chomp
    loop do
      return id_to_load if save_list.include?(id_to_load)
      until save_list.include?(id_to_load)
        print 'Please enter a valid save number: '
        id_to_load = gets.chomp
      end
    end
  end

  def prompt_menu_choice
    save_list = scan_saves
    choice = ''
    loop do
      choice = gets.chomp
      if choice == '1'
        break
      elsif choice == '2' && save_list.length.positive?
        break
      elsif choice == '2' && save_list.empty?
        print 'No saves found! Please create a new game: '
      else
        print 'Please enter 1 or 2: '
      end
    end
    choice == '1' ? create_save : load_save
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
