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
#    plain_text_byte_array = []
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
    key = Array.new(512/16) {0x00} # 512 bits / 16 bits = 32 array slots

    input_blocks.each do |block|

      previous_key = key

      # output of encryption becomes key for following iteration
      encrypted_state = encryptor.encrypt_state(block, key)
      key = encrypted_state

      # new key preprocessed by XOR-ing to previous key
      key.each_index {|i| key[i] = key[i] ^ previous_key[i]}

      # new key preprocessed by XOR-ing to input bits
      key.each_index {|i| key[i] = key[i] ^ block[i]}

    end

    encrypted_state
  end

end

plain_text = Array.new(512/16) {0x00}
cipher = WhirlpoolCipher.new
output = cipher.hash(plain_text)
puts output

