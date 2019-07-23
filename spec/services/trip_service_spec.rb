require 'spec_helper'
require './app/services/trip_service'

describe 'Trip Service' do
  it 'populates database and redis' do

    # Setup
    # Clear Redis
    $redis.flushdb

    # Retrieve step data
    google_map_service_steps = JSON.load(File.open('./spec/saved_responses/denver_ogden_steps.json'))

    # POI table populating
    options_hash = {col_sep: ",", headers: true,
      header_converters: :symbol, converters: :numeric}
    pois = CSV.open('spec/saved_responses/ogden_poi.csv', options_hash)

    poi_hashes = pois.map{ |row| row.to_hash }

    poi_hashes.each do |hash|
      create(:poi,
          ne_latitude: hash[:nelat],
          ne_longitude: hash[:nelng],
          sw_latitude: hash[:swlat],
          sw_longitude: hash[:swlng],
          name: hash[:name],
          population: hash[:population],
          state: hash[:state],
          land_area: hash[:land_area],
          total_area: hash[:total_area])

    end

    trip_token = "asbasdg"

    TripService.new(google_map_service_steps, trip_token)

    expect(TripService.pois.length). to be_between(10,20)
    expect(TripService.legs.length). to be_between(TripService.pois.length - 1)

    expect($redis.get("trip:#{trip.id}-coord:0")).not_to eq(nil)
    expect($redis.get("trip:#{trip.id}-coord:1000")).not_to eq(nil)
   end
end
