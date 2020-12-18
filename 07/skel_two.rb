# frozen_string_literal: true

class SkelTwo
  attr_reader :input
  def initialize(file = 'input.txt')
    @input = File.open(file, 'r')
  end

  def parsed
    @container ||= []
    @parsed ||= input.each.each_with_object(Hash.new { |h, k| h[k] = {} }) do |line, acc|
      container, contained = line.strip.gsub('.', '').gsub(/ bags?/, '').split(' contain ')

      contained.split(/, /).map {|bag|
        number, bag_name = bag.split(' ', 2)
        if bag_name != 'other'
          acc[container].merge!({bag_name => number.to_i})
        end
      }
    end
  end

  def how_many_bags?(bag, count = 0)
    return count if parsed[bag].empty?

    count + parsed[bag].sum { |child, child_count|
      [count, 1].max * how_many_bags?(child, child_count)
    }
  end
end

if $PROGRAM_NAME == __FILE__
  p SkelTwo.new('input2.txt').how_many_bags?("shiny gold", 0)
  p SkelTwo.new('input3.txt').how_many_bags?("shiny gold", 0)
  p SkelTwo.new.how_many_bags?("shiny gold", 0)
end
