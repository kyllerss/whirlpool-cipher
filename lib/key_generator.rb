require 'round'
require 'round_constants'

class KeyGenerator

  def initialize(key_state)

    @round_keys = Array.new
    round_constant_manager = RoundConstants.new
    input_state = key_state

    @round_keys << input_state.state.clone # not needed, but good to keep as reference (debugging)
    1.upto(10) do |i|
      round_constant = round_constant_manager.get_round_constant(i)
      round = Round.new(input_state, round_constant)
      round.execute # calculate round key

      input_state = round.state # will be used as input state for next Round

      @round_keys << round.state.state
    end
  end

  def get_round_key(round_key_num)

    raise "Unknown round key requested. Must be 0..10." unless 0..10 === round_key_num

    @round_keys[round_key_num]
  end
end
