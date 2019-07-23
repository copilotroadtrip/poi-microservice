require 'sinatra/base'

class PoiServiceApp < Sinatra::Base
  set :root, File.expand_path("..",__dir__)

  post '/api/v1/build_trip' do
    body = JSON.parse(request.body.read, symbolize_names: true)
    # puts body

    ts = TripService.new(body[:steps], body[:token])
    rs = rails_service(body[:token])
    puts "Leg Length: #{ts.legs.length}"
    ts.legs.each_with_index do |leg, index|
      puts "Leg: #{ index}"
      rs.post_leg(leg)
    end

    puts "POI Length: #{ts.pois.length}"
    ts.pois.each_with_index do |poi, index|
      puts "POI: #{ index}"

      rs.post_poi(poi)
    end

    rs.status_update
  end

  def rails_service(token)
    RailsService.new(token) #"http://localhost:3000/")
  end
end
