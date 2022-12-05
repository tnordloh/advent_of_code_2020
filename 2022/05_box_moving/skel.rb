# frozen_string_literal: true

class Skel
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def parsed
    @parsed ||= [:data, :steps]
    .zip(input.map(&:chomp)
    .chunk_while { |line| line.length != 0 }.to_a)
    .to_h
  end

  def data
    return @data if defined?(@data)
    parsed[:data].pop
    @data ||= parsed[:data].map { |line| line.ljust(parsed[:data].last.length + 1) }
    .map { |line| line.chars }
    .transpose
    .select { |line| line.last != " "}
    .map { |line| line.reverse }
    .map { |line| line.select {|cell| cell != " "}}
    .inject({}) { |acc, line| acc[line.shift.to_i] = line ; acc }
  end

  def steps
    parsed[:steps].map { |step| resolve_step(step) }
  end

  def resolve_step(step)
    /move (?<move>\d+) from (?<from>\d+) to (?<to>\d+)/.match(step)
  end

  def resolve
    steps.each do |step|
      step[:move].to_i.times do
        data[step[:to].to_i] << data[step[:from].to_i].pop
      end
    end
    data.keys.sort.map { |key| data[key].last}.join
  end
end

if $PROGRAM_NAME == __FILE__
  skel = Skel.new
  p skel.resolve
end
