# frozen_string_literal: true

require_relative('code')

# Mastermind stores a secret code and able to provide feedbacks from a guess
class Mastermind
  attr_reader :secret_code

  private

  def computer_mastermind
    @secret_code = Code.generate_code
  end

  def feedback(code, index)
    peg = @secret_code.fetch(code, nil)
    if peg
      return peg.include?(index) ? 'WHITE' : 'BLACK'
    end

    peg
  end
end
