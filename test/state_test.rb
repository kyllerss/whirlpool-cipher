$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'state'

class StateTest < Test::Unit::TestCase
  
  def test_initialize

    block = Array.new(64) {|i| i}

    expected_state = Array.new(8) {Array.new(8)}

    block_index = 0
    0.upto(7) do |row|
      
      0.upto(7) do |column|
        
        expected_state[row][column] = block[block_index]
        block_index = block_index + 1
      end
    end

    state = State.new(MatrixUtil.create_matrix(block))

    assert_equal(expected_state, state.state)
  end

  def test_shift_columns!

    initial_state = [[0,0,0,0,0,0,0,0],
                     [1,1,1,1,1,1,1,1],
                     [2,2,2,2,2,2,2,2],
                     [3,3,3,3,3,3,3,3],
                     [4,4,4,4,4,4,4,4],
                     [5,5,5,5,5,5,5,5],
                     [6,6,6,6,6,6,6,6],
                     [7,7,7,7,7,7,7,7]]

    expected_state = [[0,7,6,5,4,3,2,1],
                      [1,0,7,6,5,4,3,2],
                      [2,1,0,7,6,5,4,3],
                      [3,2,1,0,7,6,5,4],
                      [4,3,2,1,0,7,6,5],
                      [5,4,3,2,1,0,7,6],
                      [6,5,4,3,2,1,0,7],
                      [7,6,5,4,3,2,1,0]]

    state = State.new(MatrixUtil.create_matrix(initial_state.flatten!))

    state.shift_columns!
    
    assert_equal(expected_state, state.state)
  end
end
