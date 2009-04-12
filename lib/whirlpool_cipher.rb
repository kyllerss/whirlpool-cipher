require 'matrix_util'
require 'encryptor'
require 'message_util'

class WhirlpoolCipher

#  def hash_utf8_string(plain_text)
#
#    # break plain text into 8-bit array
#    plain_text_utf8_bits = plain_text.unpack("U*")
#
#    # convert into byte array
#    plain_text_byte_array = plain_text_utf8_bits
#
#    return hash(plain_text_byte_array)
#  end

  def hash(input_byte_array, debug = false)

    padded_byte_array = MessageUtil.pad_byte_array input_byte_array
    input_blocks = MessageUtil.chunk_into_blocks padded_byte_array

    # run each input matrix through encryptor
    encryptor = Encryptor.new
    encrypted_state = nil

    # initial key is 512 bits consisting of zeroes (0)
    iteration = 0
    key = Array.new(512/8) {0x00} # 512 bits / 8 bits = 64 array slots

    input_blocks.each do |block|

      previous_key = key

      # output of encryption becomes key for following iteration
      encrypted_state = encryptor.encrypt_state(block, key)
      key = encrypted_state

      # new key preprocessed by XOR-ing to previous key
      key.each_index {|i| key[i] ^= previous_key[i]}

      # new key preprocessed by XOR-ing to input bits
      key.each_index {|i| key[i] ^= block[i]}

      if debug
        iteration = iteration + 1
        puts "Hashed block ###{iteration}"
      end
    end

    encrypted_state.inject("") do |hash_val, item|
      hex_val = (item & 0xFF).to_s(16).upcase
      hex_val = "0" + hex_val unless hex_val.length == 2 # ensure leading zero not stripped out
      hash_val = hash_val + hex_val
      hash_val
    end
  end

end


#plain_text = ("a" * 10**6).unpack("c*")
#expected = "0C99005BEB57EFF50A7CF005560DDF5D29057FD86B20BFD62DECA0F1CCEA4AF51FC15490EDDC47AF32BB2B66C34FF9AD8C6008AD677F77126953B226E4ED8B01"
#cipher = WhirlpoolCipher.new
#output = cipher.hash(plain_text, true)

#puts output
