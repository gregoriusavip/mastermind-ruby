# frozen_string_literal: true

require_relative('code')

# Controller for the computer guessing the secret code
class AI
  def initialize
    @mapped_colors = {}
    Code::COLORS.each_with_index { |color, i| @mapped_colors[color] = i }
    @all_patterns = Code::COLORS.length.pow(4).times.map do |i|
      pattern = i.digits(Code::COLORS.length)
      pattern.fill(0, pattern.length, 4 - pattern.length).reverse
    end
  end
end
