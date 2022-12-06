# frozen_string_literal: true

class Skel2
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def parsed
    @parsed ||= input.map(&:chomp).first
  end

  def solve(message = parsed)
    message.length.times do |i|
      p message[i, 14].chars.uniq.join
      p 'against'
      p message[i, 14]
      return i+14 if message[i, 14].chars.uniq.join == message[i, 14]
    end
  end
end

if $PROGRAM_NAME == __FILE__
  skel = Skel2.new
  p skel.solve
end
