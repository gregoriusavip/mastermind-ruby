# frozen_string_literal: true

require_relative('code')
require_relative('computer_mastermind')

# Controller for the computer guessing the secret code
class AI
  attr_writer :feedback

  def initialize
    @all_patterns = Code::COLORS.length.pow(4).times.map do |i|
      pattern = i.digits(Code::COLORS.length)
      pattern.fill(0, pattern.length, 4 - pattern.length).reverse
    end
  end

  def guess
    self.last_guess = last_guess.nil? ? [0, 0, 1, 1] : process_feedback(Code.format_code(Code.map_to_code(last_guess)))
    Code.format_code(Code.map_to_code(last_guess))
  end

  def process_feedback(code)
    computer_mastermind = ComputerMastermind.new
    computer_mastermind.code_pegs = code
    computer_mastermind.simulate_feedback(@feedback, @all_patterns)
  end

  private

  attr_accessor :last_guess
end
