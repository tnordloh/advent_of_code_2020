# frozen_string_literal: true

class Skel
  attr_reader :input

  PRIORITY = (('a'..'z').to_a + ('A'..'Z').to_a).zip((1..52)).to_h
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def parsed
    @parsed ||= input.map(&:chomp).map(&:chars).each_slice(3).to_a.map do |group|
      group[0] & group[1] & group[2]
    end
    .flatten
    .sum { |badge| PRIORITY[badge] }
  end
end

if $PROGRAM_NAME == __FILE__
  skel = Skel.new
  p skel.parsed
end
