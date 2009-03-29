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

  def hash(input_byte_array)

    padded_byte_array = MessageUtil.pad_byte_array input_byte_array
    input_blocks = MessageUtil.chunk_into_blocks padded_byte_array

    # run each input matrix through encryptor
    encryptor = Encryptor.new
    encrypted_state = nil

    # initial key is 512 bits consisting of zeroes (0)
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

    end

    encrypted_state.inject("") do |hash_val, item|
      hex_val = (item & 0xFF).to_s(16).upcase
      hex_val = "0" + hex_val unless hex_val.length == 2 # ensure leading zero not stripped out
      hash_val = hash_val + hex_val
      hash_val
    end
  end

end


#plain_text = Array.new(512/8) {0x00}
plain_text = [0x61, 0x62, 0x63] # abc in ascii code
#plain_text = []
cipher = WhirlpoolCipher.new
output = cipher.hash(plain_text)
puts output

