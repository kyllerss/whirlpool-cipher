# To change this template, choose Tools | Templates
# and open the template in the editor.

class KeyGenerator

  def initialize(key_state)

    @round_keys = Array.new
    round_constant_manager = RoundConstants.new
    input_state = key_state

    @round_keys << input_state
    1.upto(10) do |i|
      round = Round.new(input_state, round_constant_manager.get_round_constant(i))
      round.execute # calculate round key

      @round_keys << round.state

      input_state = round.state # will be used as input state for next Round
    end
  end

  def get_round_key(round_key_num)

    raise "Unknown round key requested. Must be 0..10." unless 0..10 === round_key_num

    @round_key[round_key_num]
  end
end
