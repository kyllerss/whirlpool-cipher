# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'message_util'

class MessageUtilTest < Test::Unit::TestCase

  def test_chunk_into_blocks

    original_block = Array.new(64 * 8)

    chunks = MessageUtil.chunk_into_blocks(original_block)

    assert_equal 8, chunks.length

  end

  def test_create_message_length_component

#    array = []
#    byte = 7
#    array << byte[0]
#    byte >>= 1
#    array << byte[0]
#    byte >>= 1
#    array << byte[0]
#    byte >>= 1
#    array << byte[0]
#    byte >>= 1
#
#    assert_equal 0, byte
#    assert_equal [1, 1, 1, 0], array
#
#    result = array.pack("i*")
#    assert_equal 7, result

    message_length = 0xFA
    
    result = MessageUtil.create_message_length_component(message_length)
    
    assert result[0] = 0xF
    assert result[1] = 0xA
  end
end
