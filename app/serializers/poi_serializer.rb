class PoiSerializer
  def initialize(poi_info, token)
    @token = token
    @sequence_number = poi_info[:sequence_number]
    @poi = poi_info[:poi]
    @lat,@lng = @poi.center.to_a
    @time_to_poi = poi_info[:time_to_poi]
  end

  def to_json
    {
      token: @token,
      trip_poi: {
        poi_id: @poi.id,
        name: @poi.name,
        state: @poi.state,
        population: @poi.population,
        lat: @lat,
        lng: @lng,
        sequence_number: @sequence_number,
        time_to_poi: @time_to_poi
      }
    }
  end
end
