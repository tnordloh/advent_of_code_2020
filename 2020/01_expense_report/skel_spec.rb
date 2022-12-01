require 'minitest/autorun'

require_relative 'filename'
describe DragonChecksum do
  it "can make a dragon" do
    DragonChecksum.next("0").must_equal("001")
    DragonChecksum.next("1").must_equal("100")
  end

  it "can calculate a checksum" do
    DragonChecksum.checksum("110010110100").must_equal("100")

  end

end