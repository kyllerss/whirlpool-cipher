# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'whirlpool_cipher'

class WhirlpoolCipherTest < Test::Unit::TestCase

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

  def test_iso_vector_1

    plain_text = "".unpack("c*")
    expected = "19FA61D75522A4669B44E39C1D2E1726C530232130D407F89AFEE0964997F7A73E83BE698B288FEBCF88E3E03C4F0757EA8964E59B63D93708B138CC42A66EB3"
    cipher = WhirlpoolCipher.new
    output = cipher.hash(plain_text)

    assert_equal expected, output

  end

  def test_iso_vector_2

    plain_text = "a".unpack("c*")
    expected = "8ACA2602792AEC6F11A67206531FB7D7F0DFF59413145E6973C45001D0087B42D11BC645413AEFF63A42391A39145A591A92200D560195E53B478584FDAE231A"
    cipher = WhirlpoolCipher.new
    output = cipher.hash(plain_text)

    assert_equal expected, output

  end

  def test_iso_vector_3

    plain_text = "abc".unpack("c*")
    expected = "4E2448A4C6F486BB16B6562C73B4020BF3043E3A731BCE721AE1B303D97E6D4C7181EEBDB6C57E277D0E34957114CBD6C797FC9D95D8B582D225292076D4EEF5"
    cipher = WhirlpoolCipher.new
    output = cipher.hash(plain_text)

    assert_equal expected, output
  end

  def test_iso_vector_4

    plain_text = "message digest".unpack("c*")
    expected = "378C84A4126E2DC6E56DCC7458377AAC838D00032230F53CE1F5700C0FFB4D3B8421557659EF55C106B4B52AC5A4AAA692ED920052838F3362E86DBD37A8903E"
    cipher = WhirlpoolCipher.new
    output = cipher.hash(plain_text)

    assert_equal expected, output

  end

  def test_iso_vector_5

    plain_text = "abcdefghijklmnopqrstuvwxyz".unpack("c*")
    expected = "F1D754662636FFE92C82EBB9212A484A8D38631EAD4238F5442EE13B8054E41B08BF2A9251C30B6A0B8AAE86177AB4A6F68F673E7207865D5D9819A3DBA4EB3B"
    cipher = WhirlpoolCipher.new
    output = cipher.hash(plain_text)

    assert_equal expected, output

  end

  def test_iso_vector_6

    plain_text = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".unpack("c*")
    expected = "DC37E008CF9EE69BF11F00ED9ABA26901DD7C28CDEC066CC6AF42E40F82F3A1E08EBA26629129D8FB7CB57211B9281A65517CC879D7B962142C65F5A7AF01467"
    cipher = WhirlpoolCipher.new
    output = cipher.hash(plain_text)

    assert_equal expected, output

  end

  def test_iso_vector_7

    plain_text = ("1234567890" * 8).unpack("c*")
    expected = "466EF18BABB0154D25B9D38A6414F5C08784372BCCB204D6549C4AFADB6014294D5BD8DF2A6C44E538CD047B2681A51A2C60481E88C5A20B2C2A80CF3A9A083B"
    cipher = WhirlpoolCipher.new
    output = cipher.hash(plain_text)

    assert_equal expected, output

  end

  def test_iso_vector_8

    plain_text = "abcdbcdecdefdefgefghfghighijhijk".unpack("c*")
    expected = "2A987EA40F917061F5D6F0A0E4644F488A7A5A52DEEE656207C562F988E95C6916BDC8031BC5BE1B7B947639FE050B56939BAAA0ADFF9AE6745B7B181C3BE3FD"
    cipher = WhirlpoolCipher.new
    output = cipher.hash(plain_text)

    assert_equal expected, output

  end

  def test_iso_vector_9

    plain_text = ("a" * 10**6).unpack("c*")
    expected = "0C99005BEB57EFF50A7CF005560DDF5D29057FD86B20BFD62DECA0F1CCEA4AF51FC15490EDDC47AF32BB2B66C34FF9AD8C6008AD677F77126953B226E4ED8B01"
    cipher = WhirlpoolCipher.new
    output = cipher.hash(plain_text)

    assert_equal expected, output

  end

end


