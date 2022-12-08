# frozen_string_literal: true

class Skel
  attr_reader :input, :data
  def initialize
    @input  = File.open('input.txt', 'r')
    @data = create_grid
    @width  = nil
    @height = nil
  end

  def parsed
    @parsed ||= input.map(&:chomp)
  end

  def create_grid
    return @data if !@data.nil?
    @data = {}
    parsed.each_with_index do |row, row_number|
      row.chars.each_with_index do |tree, column_number|
        @data[[row_number, column_number]] = tree.to_i
      end
    end
    @data
  end

  def width
    @width ||= parsed.first.size
  end

  def height
    @height ||= parsed.size
  end

  def resolve
    hidden_count = (width * 2) + (height * 2) - 4
    (1...(width - 1)).each do |w|
      (1...(height - 1)).each do |h|
        hidden_count = hidden?([w, h]) ? hidden_count : hidden_count + 1
      end
    end
    hidden_count
  end
end

def hidden_on_left?(location)
  this_tree_height = @data[location]
  (0...location[0]).any? do |row|
    @data[[row, location[1]]] >= this_tree_height
  end
end

def hidden_on_right?(location)
  this_tree_height = @data[location]
  ((location[0] + 1)...width).any? do |row|
    @data[[row, location[1]]] >= this_tree_height
  end
end

def hidden_on_bottom?(location)
  this_tree_height = @data[location]
  ((location[1] + 1)...height).any? do |column|
    @data[[location[0], column]] >= this_tree_height
  end
end

def hidden_on_top?(location)
  this_tree_height = @data[location]
  (0...location[1]).any? do |column|
    @data[[location[0], column]] >= this_tree_height
  end
end

def hidden?(location)
  hidden_on_left?(location) &&
  hidden_on_right?(location) &&
  hidden_on_bottom?(location) &&
  hidden_on_top?(location) &&
  true
end

if $PROGRAM_NAME == __FILE__
  skel = Skel.new
  p "data:==="
  p skel.data
  p "==="
  p "count is #{skel.resolve}"
  p skel.width
  p skel.height
end
