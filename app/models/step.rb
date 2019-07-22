class Step
  attr_reader :dist, :time, :coordinates, :coordinate_count

  # Saves all relevant info from a step
  # Also decodes the step polyline
  def initialize(step)
    @dist = step_dist(step)
    @time = step_time(step)
    @polyline_string = step['polyline']['points']
    @coordinates = all_coordinates.map{ |coord| Coordinate.new(*coord)}
    @coordinate_count = @coordinates.length
  end

  def to_json
    {
      distance: @dist,
      duration: @time,
      coordinate_count: @coordinate_count
    }
  end

  private

  def all_coordinates
    Polylines::Decoder.decode_polyline(@polyline_string)
  end


  def step_dist(step)
    step['distance']['value']
  end

  def step_time(step)
    step['duration']['value']
  end
end
