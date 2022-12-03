# frozen_string_literal: true

class Skel
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def parsed
    @parsed ||= input.map(&:chomp)
  end

  def resolve
    parsed
  end
end

if $PROGRAM_NAME == __FILE__
  skel = Skel.new
  skel.resolve
end
