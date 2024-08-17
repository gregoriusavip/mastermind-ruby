# frozen_string_literal: true

require_relative('code')
require_relative('mastermind')
require_relative('ai')

# Create a mastermind game instance
class Game
  MAX_GUESSES = 12

  attr_reader :prev_guess, :prev_feedback

  def initialize
    puts 'Do you want to be the mastermind? (Y|y to confirm, any other character otherwise)'
    self.player_mastermind = gets.chomp.downcase.eql?('y')
    self.mastermind = Mastermind.new(player: player_mastermind)
  end

  def start
    ai_controller = player_mastermind ? AI.new : nil
    MAX_GUESSES.times do |i|
      player_mastermind ? ai_guess(ai_controller) : player_guess
      prompt(i + 1)
      if mastermind.win?
        announce(:win)
        return nil
      end
    end
    announce
  end

  private

  attr_writer :prev_guess, :prev_feedback
  attr_accessor :mastermind, :player_mastermind

  def player_guess
    self.prev_guess = Code.create_code
    self.prev_feedback = mastermind.make_guess(prev_guess)
  end

  def ai_guess(ai_controller)
    self.prev_guess = ai_controller.guess
    self.prev_feedback = mastermind.make_guess(prev_guess)
    ai_controller.feedback = prev_feedback
  end

  def prompt(cur_guess)
    puts "\nGuess No #{cur_guess}: #{format_output(prev_guess)}"
    puts "Feedback: #{prev_feedback.inject('') { |str, peg| peg.nil? ? str : "#{peg} #{str}" }.chomp}\n\n"
  end

  def announce(state = :lose)
    if state == :win
      puts 'Correct!'
    else
      puts 'Ran out of guesses.'
    end
    puts "The pegs are: #{format_output(mastermind.code_pegs)}"
  end

  def format_output(hash_colors)
    colors = Array.new(4)
    hash_colors.each_pair do |color, indices|
      indices.to_a.each { |index| colors[index] = color }
    end
    "1: #{colors[0]} 2: #{colors[1]} 3: #{colors[2]} 4: #{colors[3]}"
  end
end
