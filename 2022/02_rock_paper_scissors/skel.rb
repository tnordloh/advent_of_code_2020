# frozen_string_literal: true

class Skel
  attr_reader :input

  # X = 1 point, rock
  # Y = 2 points, paper
  # Z = 3 points, scissors
  ROCKIN_CHRISTMAS = {
    "A X" => 4, # rock, rock 1 + 3
    "A Y" => 8, # rock, paper 2 + 6
    "A Z" => 3, # rock, scissors, 3 + 0
    "B X" => 1, # paper, rock 1 + 0
    "B Y" => 5, # paper, paper 2 + 3
    "B Z" => 9, # paper, scissors 3 + 6
    "C X" => 7, # scissors, rock 1 + 6
    "C Y" => 2, # scissors, paper 2 + 0
    "C Z" => 6, # scissors, scissors 3 + 3
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
