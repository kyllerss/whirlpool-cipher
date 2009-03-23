# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'whirlpool_cipher'

class WhirlpoolCipherTest < Test::Unit::TestCase
  def test_chunk

    original_block = Array.new(513)

    block1 = original_block.slice!(0, 512)

    assert block1.length == 512
    assert original_block.length == 1

  end
end
