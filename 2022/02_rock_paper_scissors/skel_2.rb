# frozen_string_literal: true

class Skel
  attr_reader :input

  # X = lose
  # Y = draw
  # Z = win
  ROCKIN_CHRISTMAS = {
    "A X" => 3, # rock, scissors 3 + 0
    "A Y" => 4, # rock, rock 1 + 3
    "A Z" => 8, # rock, paper, 2 + 6
    "B X" => 1, # paper, rock 1 + 0
    "B Y" => 5, # paper, paper 2 + 3
    "B Z" => 9, # paper, scissors 3 + 6
    "C X" => 2, # scissors, paper 2 + 0
    "C Y" => 6, # scissors, scissors 3 + 3
    "C Z" => 7, # scissors, rock 1 + 6
  }
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def parsed
    @parsed ||= input.sum do |line|
      ROCKIN_CHRISTMAS[line.chomp]
    end
  end
end

if $PROGRAM_NAME == __FILE__
  skel = Skel.new
  p skel.parsed
end
