# frozen_string_literal: true

require_relative('mastermind')
require_relative('code')

# Class for AI to simulate a secret code and get feedbacks
class ComputerMastermind < Mastermind
  attr_writer :code_pegs

  def simulate_feedback(feedback, all_patterns)
    feedback_map = Code.map_code_pegs(feedback)
    all_patterns.filter! do |pattern|
      cur_guess = Code.format_code(Code.map_to_code(pattern))
      Code.map_code_pegs(make_guess(cur_guess)) == feedback_map
    end
    all_patterns.first
  end
end
