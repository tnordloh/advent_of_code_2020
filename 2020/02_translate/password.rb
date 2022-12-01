# frozen_string_literal: true

class Password
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def parsed2
    @parsed ||= input.each.select do |line|
      range, letter, password = line.split
      positions = range.split('-').map(&:to_i).map { |i| i - 1 }
      letter = letter.chars.first
      count = positions.count { |position| password[position] == letter }
      p count
      count == 1
    end.length
  end

  def parsed
    @parsed ||= input.each.select do |line|
      range, letter, password = line.split
      positions = range.split('-').map(&:to_i)
      letter = letter.chars.first
      p min
      p max
      p letter_count
      p password
      min <= letter_count && letter_count <= max
      break
    end.length
  end
end

if $PROGRAM_NAME == __FILE__
  # puts Password.new.parsed
  puts Password.new.parsed2
end
