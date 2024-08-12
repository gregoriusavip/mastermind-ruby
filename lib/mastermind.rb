# frozen_string_literal: true

# Create and manage a mastermind game
class Mastermind
  COLORS = %w[YELLOW ORANGE RED PINK VIOLET BLUE].freeze
  MAX_GUESSES = 12

  attr_reader :secret_code

  def computer_mastermind
    @secret_code = random_code
  end

  def random_code
    4.times.map { COLORS[Random.rand(6)] }
  end
end
