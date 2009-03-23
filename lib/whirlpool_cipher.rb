# To change this template, choose Tools | Templates
# and open the template in the editor.

class WhirlpoolCipher

  def encrypt(plain_text, key)

    # break plain text into blocks of 512 bits (64 bytes)
    

    # run through encryptor

    # concatenate output

  end

  private

  def decode_into_blocks(plain_text)

    plain_text_encoded = plain_text.unpack("U*")

    return MatrixUtil.chunk_to_matrices(plain_text_encoded)
  end
end
