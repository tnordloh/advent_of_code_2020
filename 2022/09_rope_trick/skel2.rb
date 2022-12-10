# frozen_string_literal: true

require 'set'

class Skel
  attr_accessor :knots, :head_map, :tail, :tail_map
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
    @tail_map = Set.new
    @tail_map.add [0, 0]
    @knots = [
      [0, 0], [0, 0], [0, 0],
      [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]
    ]
  end

  def parsed
    @parsed ||= input.map(&:chomp)
  end

  def move_left
    head = knots[0]
    knots[0] = [head[0] - 1, head[1]]
    move_tail
    puts "left head #{head} tail #{knots[-1]}"
    p "left knots:"
    p knots
  end

  def move_right
    head = knots[0]
    knots[0] = [head[0] + 1, head[1]]
    move_tail
    puts "right head #{head} tail #{knots[-1]}"
    p "right knots:"
    p knots
  end

  def move_up
    head = knots[0]
    knots[0] = [head[0], head[1] + 1]
    move_tail
    p "up knots:"
    p knots
  end

  def move_down
    head = knots[0]
    knots[0] = [head[0], head[1] - 1]
    move_tail
    p "down knots:"
    p knots
  end

  def move_tail
    knots.each_with_index do |tail, index|
      next if index == 0
      head = knots[index - 1]

      head_to_tail_difference = [head[0] - tail[0], head[1] - tail[1]]
      if (
        [
          [0, 0], [1, 0], [-1, 0],
          [0, -1], [0, 1], [-1, -1],
          [1, 1], [-1, +1], [+1, -1]
          ]
        ).include?(head_to_tail_difference)
        return
      elsif head_to_tail_difference == [2, 0]
        p 'bing'
        tail = [tail[0] + 1, tail[1]]
      elsif head_to_tail_difference == [-2, 0]
        p 'bang'
        tail = [tail[0] - 1, head[1]]
      elsif head_to_tail_difference == [0, 2]
        p 'bong'
        tail = [tail[0], tail[1] + 1]
      elsif head_to_tail_difference == [0, -2]
        p 'boom'
        tail = [tail[0], tail[1] - 1]
      elsif head_to_tail_difference == [1, 2]
        p 'ting'
        tail = [tail[0] + 1, tail[1] + 1]
      elsif head_to_tail_difference == [1, -2]
        p 'tang'
        tail = [tail[0] + 1, tail[1] - 1]
      elsif head_to_tail_difference == [2, 1]
        p 'tong' # observed
        tail = [tail[0] + 1, tail[1] + 1]
      elsif head_to_tail_difference == [2, -1]
        p 'toom'
        tail = [tail[0] + 1, tail[1] - 1]
      elsif head_to_tail_difference == [-2, 1]
        p 'zing'
        tail = [tail[0] - 1, tail[1] + 1]
      elsif head_to_tail_difference == [-2, -1]
        p 'zang'
        tail = [tail[0] - 1, tail[1] - 1]
      elsif head_to_tail_difference == [-1, -2]
        p 'zong'
        tail = [tail[0] - 1, tail[1] - 1]
      elsif head_to_tail_difference == [-1, 2]
        p 'zoom'
        tail = [tail[0] - 1, tail[1] + 1]
      elsif head_to_tail_difference == [2, 2]
        p 'wing'
        tail = [tail[0] + 1, tail[1] + 1]
      elsif head_to_tail_difference == [-2, 2]
        p 'wang'
        tail = [tail[0] - 1, tail[1] + 1]
      elsif head_to_tail_difference == [2, -2]
        p 'wong'
        tail = [tail[0] + 1, tail[1] - 1]
      elsif head_to_tail_difference == [-2, -2]
        p 'woom'
        tail = [tail[0] - 1, tail[1] - 1]
      end
      knots[index] = tail
      p tail
    end
    tail_map.add(knots[-1])
  end

  def resolve
    parsed.each do |line|
      direction, count = line.split(' ')
      count.to_i.times do
        if direction == "U"
          move_up
        elsif direction == "D"
          move_down
        elsif direction == "L"
          move_left
        elsif direction == "R"
          move_right
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  skel = Skel.new
  p skel.resolve
  p skel.knots
  p skel.tail_map.size
end
