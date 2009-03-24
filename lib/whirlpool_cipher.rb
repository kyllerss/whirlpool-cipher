require 'matrix_util'
require 'encryptor'

class WhirlpoolCipher

  def encrypt_utf8_string(plain_text, key)

    # break plain text into 8-bit array (totaling 512 bits = 64 bytes)
    plain_text_utf8_bits = plain_text.unpack("U*")

    return encrypt(plain_text_utf8_bits, key)
  end

  def encrypt(input_byte_array, key)

    padded_byte_array = pad_byte_array input_byte_array
    input_blocks = chunk_into_blocks padded_byte_array

    # run each input matrix through encryptor
    encryptor = Encryptor.new
    encrypted_state = nil

    # initial key is 512 bits consisting of zeroes (0)
    key = Array.new(64) {0x00} # 8 bits * 64 = 512 bits

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

  private

  def pad_byte_array(bytes_array)

    padded_message = bytes_array.clone

    # create padding such that fully padded message is multiple of 256 bits (32 bytes)
    padding = Array.new(32 - bytes_array.length % 32 ) {0x00} # padding (binary: 0000 0000)
    padding[0] = 0x80 # leading padding marker (binary: 1000 0000)

    # create message length padding component with length field - 256 bits (32 bytes)
    # length field is an unsigned int that represents number of bits in original message
    message_length = bytes_array.length * 8
    # TODO: calculate 256 field

    return padded_message + padding + message_length
  end

  def chunk_into_blocks(bytes_array)

  end
end

#key = (0..64).to_a
#plain_text = ""
#cipher = WhirlpoolCipher.new
#output = cipher.encrypt_utf8_string(plain_text, key)

