# frozen_string_literal: true

class IdCheckTwo
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
    (list - id.keys).size == 0 &&
      (1920..2002).include?(id['byr'].to_i) &&
      (2010..2020).include?(id['iyr'].to_i) &&
      (2020..2030).include?(id['eyr'].to_i) &&
      id['hgt'].match?(/^(1([5-8][0-9]|9[0-3])cm$)|(59|6[0-9]|7[0-3])in$/) &&
      id['hcl'].match?(/^#[0-9a-f]{6}$/) &&
      id['ecl'].match?(/^amb|blu|brn|gry|grn|hzl|oth$/) &&
      id['pid'].match?(/^[0-9]{9}$/)

  end
end

if $PROGRAM_NAME == __FILE__
  id_check = IdCheckTwo.new.parsed
  p id_check
end
