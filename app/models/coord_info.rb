class CoordInfo
  attr_reader :coord, :step_index, :meter_distance, :travel_time

  def initialize(coord, step)
    @coord = coord
    @step = step

    # Approximations for duration and distance assumes coordinates are equally
    # spread out along a "step"
    @approx_duration = step.time / (step.coordinate_count - 1.0)
    @approx_distance = step.dist / (step.coordinate_count - 1.0)
  end

  def to_json
    {
      coordinate: @coord.to_json,
      approx_distance: @approx_distance,
      approx_duration: @approx_duration,
      step: @step.to_json
    }.to_json
  end



  # Below are lat/lng calculation methods, kept for now, just in case

  # private

  # def find_travel_time(step_info)
  #   meter_distance / step_info.speed
  # end

  # def find_meter_distance(coord1, coord2)
  #   return 0 if coord2 == []
  #   # Using haversine formula
  #   # https://en.wikipedia.org/wiki/Haversine_formula
  #   earth_radius = 6378.137
  #   lat1 = radians(coord1.lat)
  #   lat2 = radians(coord2.lat)
  #   lng_diff = radians(coord1.lng) - radians(coord2.lng)
  #
  #   radicand = (
  #     ( Math.sin((lat1-lat2)/2) ** 2) +
  #       Math.cos(lat1) *
  #       Math.cos(lat2) *
  #     ( Math.sin(lng_diff / 2) **2 )
  #   )
  #
  #   2 * earth_radius * Math.asin( Math.sqrt( radicand ) ) * 1000
  #
  # end
  #
  # def radians(degrees)
  #   degrees * Math::PI / 180
  # end
end
