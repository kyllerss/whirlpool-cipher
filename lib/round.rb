
class Round

  attr_reader :state

  def initialize(input_state, round_key)
    @state = input_state.clone
    @round_key = round_key
  end

  def execute

    @state.sub_bytes!

    @state.shift_columns!

    @state.mix_rows!

    @state.add_round_key!(@round_key)
  end

end
