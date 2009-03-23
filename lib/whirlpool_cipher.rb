require 'matrix_util'
require 'encryptor'

class WhirlpoolCipher

  def encrypt(plain_text, key)

    # break plain text into 8-by-8 matrix blocks totaling 512 bits (64 bytes)
    input_matrices = decode_into_blocks(plain_text)

    # run each input matrix through encryptor
    encrypted_matrices = Array.new
    encryptor = Encryptor.new

    input_matrices.each {|input| encrypted_matrices << encryptor.encrypt_state(input, key)}

    # concatenate output
    encrypted_matrices.flatten!

    output = encrypted_matrices.collect{|token| token.to_s(16)}.join

    return output
  end

  private

  def decode_into_blocks(plain_text)

    plain_text_encoded = plain_text.unpack("U*")

    return MatrixUtil.chunk_to_matrices(plain_text_encoded)
  end
end

key = (0..64).to_a
plain_text = "Hello, world!"
cipher = WhirlpoolCipher.new
output = cipher.encrypt(plain_text, key)
puts output.to_s