# frozen_string_literal: true

require 'struct'
class Instruction
  attr_accessor :executed
  attr_reader :operation, :direction, value
  def initialize(operation, direction, value)
    @executed = false
    @operation = operation
    @direction = direction
    @value = value
  end

  def execute(accumulator, step)
    return false if executed
    executed = true
  end
end

class Skel
  attr_reader :input
  def initialize
    @input = File.open('input1.txt', 'r')
  end

  def parsed
    @parsed ||= input.map do |line|
      line.strip
    end
  end
end

if $PROGRAM_NAME == __FILE__
  p Skel.new.parsed
end
