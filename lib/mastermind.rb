# frozen_string_literal: true

require_relative('code')

# Mastermind stores a secret code and able to provide feedbacks from a guess
class Mastermind
  attr_reader :key_pegs, :code_pegs

  def initialize(player: false)
    player ? player_mastermind : computer_mastermind
  end

  def make_guess(guesses)
    @key_pegs = []
    guesses.each_pair do |code, indices|
      @key_pegs.push(*feedback(code, indices))
    end
    @key_pegs.shuffle
  end

  def win?
    @key_pegs.length.eql?(4) && @key_pegs.uniq.length.eql?(1) && @key_pegs[0].eql?('BLACK')
  end

  private

  def computer_mastermind
    @code_pegs = Code.generate
    nil
  end

  def player_mastermind
    @code_pegs = Code.create_code
    nil
  end

  def feedback(code, indices)
    return [nil] unless @code_pegs.key?(code)

    res = []
    code_indices = @code_pegs[code]
    code_indices.intersection(indices).length.times { res << 'BLACK' } if code_indices.intersect? indices
    [(indices - code_indices).length, (code_indices - indices).length].min.times { res << 'WHITE' }
    res
  end
end
