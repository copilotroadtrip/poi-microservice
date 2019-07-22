class PoiInfo
  attr_reader :poi, :start_coord, :end_coord

  # Keeps track of first and last time POI is seen along a route
  def initialize(poi, coordinate_index)
    @poi = poi
    @start_coord = coordinate_index
    @end_coord = coordinate_index
  end

  def update(coordinate_index)
    @end_coord = coordinate_index
  end
end
