# frozen_string_literal: true

# Create and manage a mastermind game
class Mastermind
  COLORS = %w[YELLOW ORANGE RED PINK VIOLET BLUE].freeze
  MAX_GUESSES = 12

  attr_reader :secret_code

  def computer_mastermind
    @secret_code = generate_code
  end

  def generate_code
    # Key = color code, Value = index of the color code as a set
    code = Hash.new { |hash, key| hash[key] = Set[] }
    4.times { |i| code[COLORS[Random.rand(6)]] << i }
    code
  end
end
