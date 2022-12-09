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
    visibility = []
    (1...(width - 1)).each do |w|
      (1...(height - 1)).each do |h|
        visibility << top_count([w, h]) *
                      bottom_count([w, h]) *
                      left_count([w, h]) *
                      right_count([w, h])
      end
    end
    visibility.max
  end

  def top_count(location)
    this_tree_height = @data[location]
    cells = (0...location[0]).to_a.reverse
    trees = cells.take_while do |row|
      @data[[row, location[1]]] < this_tree_height
    end.count
    cells.count == trees ? trees : trees + 1
  end

  def bottom_count(location)
    this_tree_height = @data[location]
    cells = ((location[0] + 1)...width).to_a
    trees = cells.to_a.take_while do |row|
      @data[[row, location[1]]] < this_tree_height
    end.count
    cells.count == trees ? trees : trees + 1
  end

  def left_count(location)
    this_tree_height = @data[location]
    cells = ((0...location[1])).to_a.reverse
    trees = cells.to_a.take_while do |column|
      @data[[location[0], column]] < this_tree_height
    end.count
    cells.count == trees ? trees : trees + 1
  end

  def right_count(location)
    this_tree_height = @data[location]
    cells = ((location[1] + 1)...height).to_a
    trees = cells.to_a.take_while do |column|
      @data[[location[0], column]] < this_tree_height
    end.count
    cells.count == trees ? trees : trees + 1
  end

  def hidden_on_bottom?(location)
    this_tree_height = @data[location]
    ((location[1] + 1)...height).any? do |column|
      @data[[location[0], column]] >= this_tree_height
    end
  end

  def count(location)
  end
end

if $PROGRAM_NAME == __FILE__
  skel = Skel.new
  p "data:==="
  p skel.data
  p "==="
  p "left count is #{skel.left_count([3,2])}"
  p "right count is #{skel.right_count([3,2])}"
  p "top count is #{skel.top_count([3,2])}"
  p "bottom count is #{skel.bottom_count([3,2])}"
  p '============solution=========='
  p skel.resolve
  p '=============================='
  p skel.width
  p skel.height
end
