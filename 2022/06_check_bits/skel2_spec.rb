require 'minitest/autorun'

require_relative 'skel2'
describe Skel2 do
  it "can calculate a checksum" do
    Skel2.new.solve("mjqjpqmgbljsphdztnvjfqwrcgsmlb").must_equal(19)
    Skel2.new.solve("bvwbjplbgvbhsrlpgdmjqwftvncz").must_equal(23)
    Skel2.new.solve("nppdvjthqldpwncqszvftbrmjlhg").must_equal(23)
    Skel2.new.solve("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg").must_equal(29)
    Skel2.new.solve("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw").must_equal(26)
  end
end