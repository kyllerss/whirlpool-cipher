require 'sbox'

class RoundConstants

  def initialize()
    
    sub_bytes_manager = SBox.get_instance

    @round_constants = Array.new

    1.upto(10) do |round|

      @round_constants[round] = Array.new(8) { Array.new(8) { 0x00 } }
      @round_constants[round][0].each_index do |column|

        input_byte = 8 * (round - 1) + column
        @round_constants[round][0][column] = sub_bytes_manager.sub_bytes(input_byte)
      end
    end
  end

  def get_round_constant(round_number)

    raise "Unknown round specified. Expected 1 .. 10." unless 1..10 === round_number

    @round_constants[round_number]
  end
end
