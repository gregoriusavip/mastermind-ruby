# frozen_string_literal: true

# Code provides class methods to handle a mastermind's secret code based of a set of colors
class Code
  COLORS = %w[YELLOW ORANGE RED PINK VIOLET BLUE].freeze
  COLORS_SET = COLORS.to_set
  MAPPED_COLORS = {
    'YELLOW' => 0,
    'ORANGE' => 1,
    'RED' => 2,
    'PINK' => 3,
    'VIOLET' => 4,
    'BLUE' => 5
  }.freeze

  def self.generate
    format_code(4.times.map { COLORS[Random.rand(6)] })
  end

  def self.create_code
    colors = nil
    puts 'POSSIBLE COLORS: YELLOW, ORANGE, RED, PINK, VIOLET, BLUE'
    loop do
      puts "\nInput the valid colors separated by spaces, ex: 'yellow orange red pink'"
      colors = gets.chomp.upcase.split(' ')
      break if colors.length == 4 && colors.all? { |color| Code::COLORS_SET.include?(color) }

      puts('Invalid colors')
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

  def self.map_to_code(numbers_pattern)
    numbers_pattern.map { |color_num| MAPPED_COLORS.key(color_num) }
  end

  def self.map_code_pegs(feedback)
    feedback_map = Hash.new(0)
    feedback.each { |color| feedback_map[color] += 1 unless color.nil? }
    feedback_map
  end
end
