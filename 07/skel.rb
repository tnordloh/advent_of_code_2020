# frozen_string_literal: true

class Skel
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def parsed
    @container ||= []
    @parsed ||= input.each.each_with_object(Hash.new { |h, k| h[k] = [] }) do |line, acc|
      container, contained = line.strip.gsub('.', '').gsub(/ bags?/, '').split(' contain ')
      contained = contained.split(/, /).map {|bag| bag.sub(/\d+ /, '') }
      @container << container
      contained.each do |bag|
        acc[bag] << container
      end
    end
  end

  def holders(bag, root_bags = [])
    parents = parsed[bag]
    root_bags << bag if @container.include?(bag)
    if parents.empty?
      root_bags
    else
      root_bags + parents.map { |p| holders(p, root_bags) }
    end
  end
end

if $PROGRAM_NAME == __FILE__
  p (Skel.new.holders("shiny gold").flatten.uniq - ["shiny gold"]).count
end
