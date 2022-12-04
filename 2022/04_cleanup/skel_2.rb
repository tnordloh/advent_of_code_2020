# frozen_string_literal: true

# frozen_string_literal: true

class Skel
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def parsed
    @parsed ||= input
      .map(&:chomp)
      .map { |pairs| pairs.split(',') }
      .map { |pairs| [pairs[0].split('-'), pairs[1].split('-')]}
      .map { |pairs| pairs.map {|pair| pair.map(&:to_i) }}
      .map { |pairs| [(pairs[0][0]..pairs[0][1]), (pairs[1][0]..pairs[1][1])]}
  end

  def resolve
    parsed.select {|pair| pair[0].any? { |p| pair[1].cover?(p)} }
    .count
  end
end

if $PROGRAM_NAME == __FILE__
  skel = Skel.new
  p skel.resolve
end