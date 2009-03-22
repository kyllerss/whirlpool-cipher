# To change this template, choose Tools | Templates
# and open the template in the editor.

class SBox

  def self.get_instance

    @@singleton == SBox.new unless @@singleton != nil
    return @@singleton
  end

  def initialize(verbose = false)

    # encryption mappings
    @eMap = [0x1, 0xb, 0x9, 0xc,
              0xd, 0x6, 0xf, 0x3, 
              0xe, 0x8, 0x7, 0x4, 
              0xa, 0x2, 0x5, 0x0 ]

    @invEMap = [0xf, 0x0, 0xd, 0x7,
                 0xb, 0xe, 0x5, 0xa, 
                 0x9, 0x2, 0xc, 0x1,
                 0x3, 0x4, 0x8, 0x6]

    @rMap = [0x7, 0xc, 0xb, 0xd,
              0xe, 0x4, 0x9, 0xf,
              0x6, 0x3, 0x8, 0xa,
              0x2, 0x5, 0x1, 0x0]

#    # decryption mappings
#    @reverse_eMap = [0xf, 0x0, 0xd, 0x7,
#                     0xb, 0xe, 0x5, 0xa,
#                     0x9, 0x2, 0xc, 0x1,
#                     0x3, 0x4, 0x8, 0x6]
#
#    @reverse_inv_eMap = [0x1, 0xb, 0x9, 0xc,
#                         0xd, 0x6, 0xf, 0x3,
#                         0xe, 0x8, 0x7, 0x4,
#                         0xa, 0x2, 0x5, 0x0]
#
#    @reverse_rMap = [0xf, 0xe, 0xc, 0x9,
#                     0x5, 0xd, 0x8, 0x0,
#                     0xa, 0x6, 0xb, 0x2,
#                     0x1, 0x3, 0x4, 0x7]

    # build main sbox
    @sbox = Array.new(16) {Array.new(16)}

    0.upto(15) do |row|

      0.upto(15) do |column|

        a, b = row, column

        aE = map_e(a)
        bE = map_inv_e(b)

        aR = bR = map_r(aE ^ bE)

        c = map_e(aE ^ aR)

        d = map_inv_e(bE ^ bR)

        @sbox[row][column] = c << 4 | d
        puts "sbox [#{row.to_s(16)}][#{column.to_s(16)}]: #{@sbox[row][column].to_s(16)}" if verbose
      end

    end

#    # build main decryption sbox
#    @reverse_sbox = Array.new(16) {Array.new(16)}
#
#    0.upto(15) do |row|
#
#      0.upto(15) do |column|
#
#        a, b = row, column
#
#        aE = reverse_map_e(a)
#        bE = reverse_map_inv_e(b)
#
#        aR = bR = reverse_map_r(aE ^ bE)
#
#        c = reverse_map_e(aE ^ aR)
#
#        d = reverse_map_inv_e(bE ^ bR)
#
#        @reverse_sbox[row][column] = c << 4 | d
#        puts "inv sbox [#{row.to_s(16)}][#{column.to_s(16)}]: #{@reverse_sbox[row][column].to_s(16)}" if verbose
#      end
#
#    end
  end

  def map_e(input)
    @eMap[input]
  end

  def map_inv_e(input)
    @invEMap[input]
  end

  def map_r(input)
    @rMap[input]
  end

#  def reverse_map_e(input)
#    @reverse_eMap[input]
#  end
#
#  def reverse_map_inv_e(input)
#    @reverse_inv_eMap[input]
#  end
#
#  def reverse_map_r(input)
#    @reverse_rMap[input]
#  end

  def sub_bytes(input_byte)

    row = (input_byte & 0xf0) >> 4
    column = input_byte & 0xf

    @sbox[row][column]
  end

#  def inv_sub_bytes(input_byte)
#
#    row = (input_byte & 0xf0) >> 4
#    column = input_byte & 0xf
#
#    @reverse_sbox[row][column]
#  end


end

sbox = SBox.new(false)
input = 0x12
sbox_output = sbox.sub_bytes(input)
#inv_sbox_output = sbox.inv_sub_bytes(sbox_output)
puts "input: #{input.to_s(16)} -> sbox: #{sbox_output.to_s(16)}" #, inv-sbox: #{inv_sbox_output.to_s(16)}"