# frozen_string_literal: true

# Code provides class methods to handle a mastermind's secret code based of a set of colors
class Code
  COLORS = %w[YELLOW ORANGE RED PINK VIOLET BLUE].freeze
  COLORS_SET = COLORS.to_set

  def self.generate
    # Key = color code, Value = index of the color code as a set
    code = Hash.new { |hash, key| hash[key] = Set[] }
    4.times { |i| code[COLORS[Random.rand(6)]] << i }
    code
  end

  def self.create_guess
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
end
