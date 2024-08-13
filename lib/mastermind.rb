# frozen_string_literal: true

# Create and manage a mastermind game
class Mastermind
  COLORS = %w[YELLOW ORANGE RED PINK VIOLET BLUE].freeze
  COLORS_SET = COLORS.to_set
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

  def create_guess
    4.times.map do |i|
      color = nil
      puts 'POSSIBLE COLORS: YELLOW, ORANGE, RED, PINK, VIOLET, BLUE'
      loop do
        puts "\nGuess no. #{i + 1}: "
        color = gets.chomp.upcase
        COLORS_SET.include?(color) ? break : puts('Invalid guess')
      end
      color
    end
  end

  def feedback(code, index)
    peg = @secret_code.fetch(code, nil)
    if peg
      return peg.include?(index) ? 'WHITE' : 'BLACK'
    end

    peg
  end
end
