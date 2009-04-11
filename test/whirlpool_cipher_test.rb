# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'whirlpool_cipher'

class WhirlpoolCipherTest < Test::Unit::TestCase

  def test_iso_vector_abc

    plain_text = "abc".unpack("c*")
    expected = "4E2448A4C6F486BB16B6562C73B4020BF3043E3A731BCE721AE1B303D97E6D4C7181EEBDB6C57E277D0E34957114CBD6C797FC9D95D8B582D225292076D4EEF5"
    cipher = WhirlpoolCipher.new
    output = cipher.hash(plain_text)

    assert_equal expected, output
  end

  def test_iso_vector_abcdbcdecdefdefgefghfghighijhijk

    plain_text = "abcdbcdecdefdefgefghfghighijhijk".unpack("c*")
    expected = "2A987EA40F917061F5D6F0A0E4644F488A7A5A52DEEE656207C562F988E95C6916BDC8031BC5BE1B7B947639FE050B56939BAAA0ADFF9AE6745B7B181C3BE3FD"
    cipher = WhirlpoolCipher.new
    output = cipher.hash(plain_text)

    assert_equal expected, output
  end
end


