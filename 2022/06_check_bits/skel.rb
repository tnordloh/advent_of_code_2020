# frozen_string_literal: true

class Skel
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def parsed
    @parsed ||= input.map(&:chomp).first
  end

  def solve(message = parsed)
    message.length.times do |i|
      p message[i, 4].chars.uniq.join
      p 'against'
      p message[i, 4]
      return i+4 if message[i, 4].chars.uniq.join == message[i, 4]
    end
  end
end

if $PROGRAM_NAME == __FILE__
  skel = Skel.new
  p skel.solve
end
