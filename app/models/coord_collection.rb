class CoordCollection

  def initialize(trip_id)
    @trip_id = trip_id
    @max_index = 0
  end

  # def self.refresh(trip_id, max_index)
    # Allow for redis querying
  # end

  # def self.destroy(trip_id, max_index)
    # REMOVE redis info
  # end


  # Add new coordinate to redis
  def update(coordinate, coordinate_index, step)
    info = CoordInfo.new(coordinate, step)

    redis.set(key(coordinate_index), info.to_json)

    @max_index =  [coordinate_index, @max_index].max
  end

  # Return duration/distance for adding to trip_legs db
  def segment_info(start, stop)
    segment = segment(start,stop)

    {
      duration: time_to_hours(segment_duration(segment)),
      distance: segment_distance(segment)
    }
  end

  private
  def segment_distance(segment)
    segment.map { |info| info[:approx_distance]}.sum
  end

  def segment_duration(segment)
    segment.map { |info| info[:approx_duration]}.sum
  end

  # Pull out all relevant coordinates from segment
  def segment(start, stop)
    ((start+1)..stop).map do |index|
        JSON.parse(redis.get(key(index)), symbolize_names: true)
    end
  end

  # Consistent keys for storing coordinates in redis
  def key(coordinate_index, trip_id = @trip_id)
    "trip:#{@trip_id}-coord:#{coordinate_index}"
  end

  def redis
    $redis
  end

  def time_to_hours(seconds)
    seconds / 3600.0
  end
end
