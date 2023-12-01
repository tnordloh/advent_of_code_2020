# frozen_string_literal: true

class Skel
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def parsed
    @parsed ||= input.map(&:chomp)
    .map { |line| [line.chars.first, line.chars.last].join.to_i }
    .sum
  end

  def resolve
    parsed
  end
end

if $PROGRAM_NAME == __FILE__
  skel = Skel.new
  p skel.resolve
end
