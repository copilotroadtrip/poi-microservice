class Coordinate
  attr_reader :lat, :lng
  def initialize(lat, lng = nil)
    if lng == nil
      @lat = lat[0]
      @lng = lat[1]
    else
      @lat = lat
      @lng = lng
    end
  end

  def to_json
    {
      lat: lat,
      lng: lng
    }
  end

  def to_a
    [lat,lng]
  end

  # Custom comparaison between coordinates, obviated with using coordinate indicies
  # def ==(other_object)
  #   return false if other_object.class != Coordinate
  #   return lat == other_object.lat && lng == other_object.lng
  # end
end
