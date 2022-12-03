# frozen_string_literal: true

class Skel
  attr_reader :input

  PRIORITY = (('a'..'z').to_a + ('A'..'Z').to_a).zip((1..52)).to_h
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def parsed
    @parsed ||= input.map do |line|
      line.chomp.chars.each_slice((line.chomp.size) / 2).to_a
    end
  end

  def common_value
    parsed.map { |lists| lists[0] & lists[1] }.flatten.sum { |i| PRIORITY[i] }
  end
end

if $PROGRAM_NAME == __FILE__
  skel = Skel.new
  p skel.common_value
end
