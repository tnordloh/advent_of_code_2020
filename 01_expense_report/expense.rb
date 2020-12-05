# frozen_string_literal: true

require 'set'

class Expense
  attr_reader :input
  def initialize(filename: 'input.txt')
    @input = File.open(filename, 'r')
  end

  def parsed
    @parsed ||= input.map { |line| line.strip.to_i }
  end

  def find_adder(val: 2020, combinations: 2)
    parsed.combination(combinations).find { |comb| comb.sum == val }.reduce(:*)
  end
end

if $PROGRAM_NAME == __FILE__
  expense = Expense.new
  p expense.find_adder(combinations: 2)
  p expense.find_adder(combinations: 3)
end
