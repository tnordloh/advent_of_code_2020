# frozen_string_literal: true

class PlaneSeat
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
  end

  MAPPER = { "B" => "1", "F" => "0", "L" => "0", "R" => "1", }.freeze
  def parsed
    @parsed ||= input.map { |line| line.strip.gsub(/./, MAPPER).to_i(2) }.sort
  end

  def last_seat
    parsed.last
  end

  def seat_with_two_neighbors
    parsed.find {|seat| !parsed.include?(seat + 1) && parsed.include?(seat + 2) } + 1
  end
end

if $PROGRAM_NAME == __FILE__
  plane_seat = PlaneSeat.new
  p plane_seat.last_seat
  p plane_seat.seat_with_two_neighbors
end
