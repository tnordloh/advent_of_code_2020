# frozen_string_literal: true

class Toboggan
  attr_reader :input, :map_length
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def parsed
    @parsed ||= input.each.with_index(0).reduce({}) do |acc, (line, y_index)|
      line = line.strip
      @map_length ||= line.length
      line.chars.each.with_index(0) do |char, x_index|
        acc[[x_index, y_index]] = char
      end
      acc
    end
  end

  def walk(right:, down:)
    parsed
    trees_bumped = 0
    1.upto(Float::INFINITY) do |index|
      location=[(right * index) % map_length, down * index]
      return trees_bumped if parsed[location].nil?

      trees_bumped += 1 if parsed[location] == '#'
    end
  end

end

if $PROGRAM_NAME == __FILE__
  t = Toboggan.new
  p t.walk(right: 3, down: 1)
  p [
    { right: 1, down: 1},
    { right: 3, down: 1},
    { right: 5, down: 1},
    { right: 7, down: 1},
    { right: 1, down: 2},
  ].reduce(1) { |acc, args|
    acc * t.walk(**args)
  }
end
