# frozen_string_literal: true

# Create and manage a mastermind game
class Mastermind
  COLORS = %i[YELLOW ORANGE RED PINK VIOLET BLUE].freeze

  def computer_mastermind
    secret_code = random_code
  end

  def random_code
    4.times.map { COLORS[Random.rand(6)] }
  end
end

Mastermind.new.computer_mastermind
