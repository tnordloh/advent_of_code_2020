# frozen_string_literal: true

class Skel
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def parsed
    @parsed ||= input.read.split(/\n{2,}/).each.reduce(0) do |acc, line|
      acc + line.scan(/[a-z]/).sort.uniq.count
    end
  end
end

if $PROGRAM_NAME == __FILE__
  p Skel.new.parsed
end
