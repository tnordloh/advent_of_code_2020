# frozen_string_literal: true

class IdCheck
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def parsed
    @parsed ||= input.read.split(/\n{2,}/).each.count do |line|
      emparsulated =  line.split(/\n| /).map { |x| x.split(':') }.to_h
      valid?(emparsulated)
    end
  end

  def valid?(id)
    list = ["byr", 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
    (list - id.keys).size == 0
  end
end

if $PROGRAM_NAME == __FILE__
  id_check = IdCheck.new.parsed
  p id_check
end
