class LegInfo
  attr_reader :time, :distance

  def initialize(leg_info)
    @time = parse_time(leg_info['duration']['value'])
    @distance = parse_distance(leg_info['distance']['value'])
  end

  def json_with_id(index)
    {
      distance: "#{distance.round} mi",
      duration_in_hours: time,
      id: index
    }
  end

  private
  def parse_time(seconds)
    seconds / 3600.0
  end

  def parse_distance(meters)
    meters / 1609.344
  end
end
