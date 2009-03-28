
class MessageUtil

  def self.pad_byte_array(bytes_array)

    # create padding such that fully padded message is odd multiple of 256 bits (32 bytes)
    padding = Array.new((256/8) - bytes_array.length % (256/8)) {0x00}
    padding[0] = 0x80 # leading padding marker (binary: 1000 0000)

    # create message length padding component with length field - 256 bits (32 bytes)
    # length field is an unsigned int that represents number of bits in original message
    message_bit_length = bytes_array.length * 8
    message_length = create_message_length_component message_bit_length

    return bytes_array + padding + message_length
  end

  def self.chunk_into_blocks(original_array)

    raise 'Message must be a multiple of 512 bits.' unless original_array.length % (512/8) == 0

    bytes_array = original_array.clone

    chunks = Array.new
    while bytes_array.length > 0
      chunks << bytes_array.slice!(0, (512/8))
    end

    chunks
  end

  # This is somewhat of a convoluted way of expanding an int into into its 256 bits integer
  # representation in Ruby. Ruby automatically resizes numbers based on size. To force
  # ruby to represent the integer as 256 bits, the following code iteratively
  # constructs a byte array out of hex strings that represents the full number.
  #
  # If you know of a more concise way, by all means let me know :)
  #
  def self.create_message_length_component message_length

    hex_string = message_length.to_s(16)
    hex_string = "0" + hex_string unless hex_string % 2 == 0 # force even numbered hex string
    hex_string_array = hex_string.scan(/../) # break up hex string into array

    # add the appropriate number of zero-bits preceeding the actual int value
    message_length_component = Array.new((256/8) - hex_string_array.length) {0x00}
    
    # add remaining int value array elements to the array
    hex_string_array.each {|hex_val| message_length_component << hex_val.to_i(16)}

    message_length_component
  end
end