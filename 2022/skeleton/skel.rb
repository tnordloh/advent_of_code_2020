# frozen_string_literal: true

class Skel
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def parsed
    @parsed ||= input.each.reduce do |line|
      # parse line here
    end
  end
end

if $PROGRAM_NAME == __FILE__
  skel = Skel.new
end
