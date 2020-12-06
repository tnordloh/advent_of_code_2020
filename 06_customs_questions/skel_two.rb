# frozen_string_literal: true

class SkelTwo
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def parsed
    @parsed ||= input.read.split(/\n{2,}/).each.reduce(0) do |acc, line|
      require 'pry' ; binding.pry
      acc + line.split(/\n/).map(&:chars).reduce { |acc2, answers| acc2 & answers }.length
    end
  end
end

if $PROGRAM_NAME == __FILE__
  p SkelTwo.new.parsed
end
