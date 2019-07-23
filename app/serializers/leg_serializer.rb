class LegSerializer
  def initialize(leg_info, token)
    @token = token
    @leg = leg_info
  end

  def to_json
    {
      token: @token,
      distance: @leg[:distance],
      duration: @leg[:duration],
      sequence_number: @leg[:sequence_number]
    }
  end
end
