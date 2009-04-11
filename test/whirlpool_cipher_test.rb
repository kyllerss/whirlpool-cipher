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

  def test_vector_wikipedia1

    plain_text = "The quick brown fox jumps over the lazy dog".unpack("c*")
    expected = "B97DE512E91E3828B40D2B0FDCE9CEB3C4A71F9BEA8D88E75C4FA854DF36725FD2B52EB6544EDCACD6F8BEDDFEA403CB55AE31F03AD62A5EF54E42EE82C3FB35"
    cipher = WhirlpoolCipher.new
    output = cipher.hash(plain_text)

    assert_equal expected, output
  end

  def test_vertor_wikipedia2

    plain_text = "The quick brown fox jumps over the lazy eog".unpack("c*")
    expected = "C27BA124205F72E6847F3E19834F925CC666D0974167AF915BB462420ED40CC50900D85A1F923219D832357750492D5C143011A76988344C2635E69D06F2D38C"
    cipher = WhirlpoolCipher.new
    output = cipher.hash(plain_text)

    assert_equal expected, output
  end

  def test_vertor_wikipedia3

    plain_text = "test".unpack("c*")
    expected = "B913D5BBB8E461C2C5961CBE0EDCDADFD29F068225CEB37DA6DEFCF89849368F8C6C2EB6A4C4AC75775D032A0ECFDFE8550573062B653FE92FC7B8FB3B7BE8D6"
    cipher = WhirlpoolCipher.new
    output = cipher.hash(plain_text)

    assert_equal expected, output
  end
end


