# frozen_string_literal: true

require_relative('code')
require_relative('mastermind')

# Create a mastermind game instance
class Game
  MAX_GUESSES = 12

  attr_reader :prev_guesses, :prev_feedbacks

  def initialize
    @prev_guesses = []
    @prev_feedbacks = []
    puts 'Do you want to be the mastermind? (Y|y to confirm, any other character otherwise)'
    @player_mastermind = gets.chomp.downcase.eql?('y') ? true : false
    @mastermind = Mastermind.new(player: @player_mastermind)
  end

  def start
    # assume only computer can be the mastermind
    MAX_GUESSES.times do |i|
      @prev_guesses << Code.create_code
      @prev_feedbacks << @mastermind.make_guess(prev_guesses.last)
      prompt(i + 1)
      if @mastermind.win?
        announce(:win)
        return nil
      end
    end
    announce
  end

  private

  def prompt(cur_guess)
    puts "\nGuess No #{cur_guess}: #{format_output(prev_guesses.last)}"
    puts "Feedback: #{prev_feedbacks.last.inject('') { |str, peg| peg.nil? ? str : "#{peg} #{str}" }.chomp}\n\n"
  end

  def announce(state = :lose)
    if state == :win
      puts 'Correct!'
    else
      puts 'Ran out of guesses.'
    end
    puts "The pegs are: #{format_output(@mastermind.code_pegs)}"
  end

  def format_output(hash_colors)
    colors = Array.new(4)
    hash_colors.each_pair do |color, indices|
      indices.to_a.each { |index| colors[index] = color }
    end
    "1: #{colors[0]} 2: #{colors[1]} 3: #{colors[2]} 4: #{colors[3]}"
  end
end
