# frozen_string_literal: true

require_relative('code')

# Mastermind stores a secret code and able to provide feedbacks from a guess
class Mastermind
  attr_reader :key_pegs, :code_pegs

  def initialize
    # Assume computer is the mastermind
    computer_mastermind
  end

  def make_guess(guesses)
    @key_pegs = guesses.map.with_index do |guess, i|
      feedback(guess, i)
    end
    @key_pegs.shuffle
  end

  def win?
    @key_pegs.uniq.length.eql?(1) && @key_pegs[0].eql?('BLACK')
  end

  private

  def computer_mastermind
    @code_pegs = Code.generate
    nil
  end

  def feedback(code, index)
    peg = @code_pegs.fetch(code, nil)
    if peg
      return peg.include?(index) ? 'BLACK' : 'WHITE'
    end

    peg
  end
end
