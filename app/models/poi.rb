class Poi < ActiveRecord::Base
  has_many :trip_pois
  has_many :trips, through: :trip_pois

  validates_presence_of :name, :population, :state,
                        :land_area, :total_area,
                        :ne_latitude, :ne_longitude,
                        :sw_latitude, :sw_longitude

  def self.poi_at_location(lat, lng)
    pois =  Poi
              .where('ne_latitude >= ?', lat)
              .where('sw_latitude <= ?', lat)
              .where( 'sw_longitude <= ?', lng)
              .where('ne_longitude >= ?', lng)
    return nil if pois == []
    pois
  end

  def self.population_at_location(lat, lng)
    at_location = self.poi_at_location(lat, lng)
    if at_location
      return at_location.sum(:population)
    else
      return 0
    end
  end

  def center
    lat_diff = ne_latitude - sw_latitude
    mid_lat = ne_latitude - (lat_diff/2)

    lng_diff = ne_longitude - sw_longitude
    mid_lng = ne_longitude - (lng_diff/2)

    Coordinate.new(mid_lat, mid_lng)
  end
end
