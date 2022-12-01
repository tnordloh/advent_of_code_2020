# frozen_string_literal: true

class Skel
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def parsed
    @parsed ||= input
    .readlines
    .map(&:chomp)
    .map(&:to_i)
    .chunk_while { |x| x != 0 }
    .map(&:sum)
    .sort
    .last(3)
    .sum
  end
end

if $PROGRAM_NAME == __FILE__
  skel = Skel.new
  p skel.parsed
end
