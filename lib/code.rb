# frozen_string_literal: true

# Code provides class methods to handle a mastermind's secret code based of a set of colors
class Code
  COLORS = %w[YELLOW ORANGE RED PINK VIOLET BLUE].freeze
  COLORS_SET = COLORS.to_set

  def self.generate
    format_code(4.times.map { COLORS[Random.rand(6)] })
  end

  def self.create_guess
    colors = nil
    puts 'POSSIBLE COLORS: YELLOW, ORANGE, RED, PINK, VIOLET, BLUE'
    loop do
      puts "\nInput the valid colors separated by spaces, ex: 'yellow orange red pink'"
      colors = gets.chomp.upcase.split(' ')
      break if colors.length == 4 && colors.all? { |color| Code::COLORS_SET.include?(color) }

      puts('Invalid guess')
    end
    format_code(colors)
  end

  ##
  # Given an array of colors, format them to Hash: Key = color code, Value = indices of the color code as a set.
  # Does not validate the input.
  def self.format_code(colors)
    code = Hash.new { |hash, key| hash[key] = Set[] }
    colors.each_with_index { |color, i| code[color] << i }
    code
  end

  private_class_method :format_code
end
