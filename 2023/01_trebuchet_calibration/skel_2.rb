# frozen_string_literal: true

class Skel
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
  end

  MAP = {
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }
  REGEX = %r{#{MAP.keys.join("|")}}

  def parsed
    @parsed ||= input.map(&:chomp)
    .map { |line| line.gsub('oneight', 'oneeight') }
    .map { |line| line.gsub('threeight', 'threeeight') }
    .map { |line| line.gsub("nineight", "nineeight") }
    .map { |line| line.gsub("fiveight", 'fiveeight') }
    .map { |line| line.gsub("sevenine", "sevennine") }
    .map { |line| line.gsub("eighthree", "eightthree") }
    .map { |line| line.gsub("eightwo", "eighttwo") }
    .map { |line| line.gsub("twone", "twoone") }
    .map { |line| line.gsub(REGEX, MAP) }
    .map { |line| line.gsub(/[a-zA-Z]/,'') }
    .map { |line| [line.chars.first, line.chars.last].join.to_i }
    .sum
  end

  def resolve
    parsed
  end
end

if $PROGRAM_NAME == __FILE__
  skel = Skel.new
  p skel.resolve
end
