class State

  attr_reader :state

  def initialize(block)
    
    raise "Invalid dimensions for block" unless block.length == 64

    @state = Array.new(8) {Array.new(8)}

    0.upto(63) do |i|
      
      row, column = i.divmod(8)
      
      @state[row][column] = block[i]
    end

    @mix_rows_constant = [[0x01, 0x01, 0x04, 0x01, 0x08, 0x05, 0x02, 0x09],
                          [0x09, 0x01, 0x01, 0x04, 0x01, 0x08, 0x05, 0x02],
                          [0x02, 0x09, 0x01, 0x01, 0x04, 0x01, 0x08, 0x05],
                          [0x05, 0x02, 0x09, 0x01, 0x01, 0x04, 0x01, 0x08],
                          [0x08, 0x05, 0x02, 0x09, 0x01, 0x01, 0x04, 0x01],
                          [0x01, 0x08, 0x05, 0x02, 0x09, 0x01, 0x01, 0x04],
                          [0x04, 0x01, 0x08, 0x05, 0x02, 0x09, 0x01, 0x01],
                          [0x01, 0x04, 0x01, 0x08, 0x05, 0x02, 0x09, 0x01]]

  end

  def shift_columns!

    0.upto(7) do |column_num|

      next if column_num == 0

      # extract column
      temp_column_block = Array.new()
      @state.each {|row_block| temp_column_block.push(row_block[column_num])}

      # shift
      0.upto(column_num - 1) { temp_column_block.unshift(temp_column_block.pop)  }

      # store contents
      @state.each_index do |row_index|
        @state[row_index][column_num] = temp_column_block[row_index]
      end
      
    end
  end

  def mix_rows!

    @state = MatrixUtil.multiply(@state, @mix_rows_constant)
  end

  def add_round_key!(round_key)
    
  end
end