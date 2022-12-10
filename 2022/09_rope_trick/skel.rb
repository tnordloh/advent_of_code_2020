# frozen_string_literal: true

require 'set'

class Skel
  attr_accessor :head, :head_map, :tail, :tail_map
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
    @head_map = Set.new
    @head_map.add [0, 0]
    @tail_map = Set.new
    @tail_map.add [0, 0]
    @head = [0, 0]
    @tail = [0, 0]
  end

  def parsed
    @parsed ||= input.map(&:chomp)
  end

  def move_left
    self.head = [head[0] - 1, head[1]]
    self.head_map.add(head)
    move_tail
    puts "left head #{head} tail #{tail}"
  end

  def move_right
    self.head = [head[0] + 1, head[1]]
    self.head_map.add(head)
    move_tail
    puts "right head #{head} tail #{tail}"
  end

  def move_up
    self.head = [head[0], head[1] + 1]
    self.head_map.add(head)
    move_tail
    puts "up head #{head} tail #{tail}"
  end

  def move_down
    self.head = [head[0], head[1] - 1]
    self.head_map.add(head)
    move_tail
    puts "down head #{head} tail #{tail}"
  end

  def move_tail
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
      self.tail = [tail[0] + 1, tail[1]]
    elsif head_to_tail_difference == [-2, 0]
      p 'bang'
      self.tail = [tail[0] - 1, head[1]]
    elsif head_to_tail_difference == [0, 2]
      p 'bong'
      self.tail = [tail[0], tail[1] + 1]
    elsif head_to_tail_difference == [0, -2]
      p 'boom'
      self.tail = [tail[0], tail[1] - 1]
    elsif head_to_tail_difference == [1, 2]
      p 'ting'
      self.tail = [tail[0] + 1, tail[1] + 1]
    elsif head_to_tail_difference == [1, -2]
      p 'tang'
      self.tail = [tail[0] + 1, tail[1] - 1]
    elsif head_to_tail_difference == [2, 1]
      p 'tong' # observed
      self.tail = [tail[0] + 1, tail[1] + 1]
    elsif head_to_tail_difference == [2, -1]
      p 'toom'
      self.tail = [tail[0] + 1, tail[1] - 1]
    elsif head_to_tail_difference == [-2, 1]
      p 'zing'
      self.tail = [tail[0] - 1, tail[1] + 1]
    elsif head_to_tail_difference == [-2, -1]
      p 'zang'
      self.tail = [tail[0] - 1, tail[1] - 1]
    elsif head_to_tail_difference == [-1, -2]
      p 'zong'
      self.tail = [tail[0] - 1, tail[1] - 1]
    elsif head_to_tail_difference == [-1, 2]
      p 'zoom'
      self.tail = [tail[0] - 1, tail[1] + 1]
    end
    tail_map.add(tail)
    p tail
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
  p skel.head_map
  p skel.resolve
  p skel.head
  p skel.head_map.size
  p skel.tail_map.size
end
