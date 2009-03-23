require 'round'
require 'round_constants'
require 'key_generator'
require 'matrix_util'
require 'state'

class Encryptor

  def initialize
    @round_constant_manager = RoundConstants.new
  end

  def encrypt_state(raw_state, key)

    encryption_state = State.new(raw_state)

    # perform key expansion
    key_state = create_key_state(key)
    key_generator = KeyGenerator.new(key_state)

    #
    # execute encryption rounds
    #

    # Step 0: Add cipher key as the initial round key
    encryption_state.add_round_key!(key_state.state)
    
    # Steps 1-10: Execute encryption rounds
    1.upto(10) do |i|
      round = Round.new(encryption_state, key_generator.get_round_key(i))
      round.execute # calculate round key
    end

    # return encrypted state
    return encryption_state.state
  end

  private
  def create_key_state(key)
    State.new(MatrixUtil.create_matrix(key))
  end
end
