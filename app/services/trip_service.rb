class TripService

  attr_reader :pois, :legs, :ready
  def initialize(steps, trip_token)
    @trip_token = trip_token

    # Initializing aggregator objects
    @poi_collection = PoiCollection.new
    @coord_collection = CoordCollection.new(@trip_token)

    # Should save coord_collection info (trip_id and max_index) to trip table
    # Will allow for refresh and teardown

    # Go through each step
    parse_steps(steps)

    @places = @poi_collection.ordered_pois

    # Add places (in order) to trip_pois table
    @pois = save_places

    # Add Legs (in order) to trip_legs table
    @legs = save_legs

    # Set trip.status = "ready"
    @ready = true
  end

  def parse_steps(steps)
    coordinate_index = 0
    steps.each do |step|
      step = Step.new(step)

      # Within each step, find POIs, store coordinates, keep track of number of coordinates
      coordinate_index = parse_step(step, coordinate_index)
    end
  end

  def parse_step(step, coordinate_index)
    step.coordinates.each_with_index do |coordinate, step_c_index|
      if step_c_index != 0 # First coordinate of each step is a repeat
        # Find POIs at location
        point_pois = Poi.poi_at_location(*coordinate.to_a)
        # Update POICollector with new points
        # (POI Collector determines whether or not to store a point)
        @poi_collection.update(point_pois, coordinate_index) if point_pois

        # Give coordinate to the coordinate collector, which will store in Redis
        @coord_collection.update( coordinate, coordinate_index, step )
        coordinate_index += 1
      end
    end

    coordinate_index
  end

  def save_places
    pois = []
    last_poi_start_coord = 0
    @places.each_with_index do |poi_info, index|
      duration = @coord_collection.segment_info(last_poi_start_coord, poi_info.start_coord)[:duration]
      pois << {poi: poi_info.poi, sequence_number: index, time_to_poi: duration}
    end
    pois
  end

  def save_legs
    sequence_number = 1
    legs = []
    # Iterate through each pair of places
    @places.each_cons(2) do |(start_poi, end_poi)|
      segment = [ start_poi.start_coord, end_poi.start_coord ]

      # Calculate time + distance with coordinates
      segment_info = @coord_collection.segment_info(*segment)

      legs << {
        sequence_number: sequence_number,
        duration:segment_info[:duration],
        distance:segment_info[:distance]
      }

      sequence_number += 1
    end
    legs
  end

  def set_trip_to_ready
    @trip.status = "ready"
    @trip.save
  end

end
