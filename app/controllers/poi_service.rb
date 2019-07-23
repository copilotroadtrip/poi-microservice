require 'sinatra/base'

class PoiServiceApp < Sinatra::Base
  set :root, File.expand_path("..",__dir__)

  post '/api/v1/build_trip' do
    puts "within endpoint"
    body = JSON.parse(request.body.read, symbolize_names: true)
    # puts body
    p "Build Trip Service"
    ts = TripService.new(body[:steps], body[:token])
    p "Build rails Service"

    rs = rails_service(body[:token])
    p "Leg Length: #{ts.legs.length}"
    ts.legs.each_with_index do |leg, index|
      p "Leg: #{ index}"
      rs.post_leg(leg)
    end

    p "POI Length: #{ts.pois.length}"
    ts.pois.each_with_index do |poi, index|
      p "POI: #{ index}"

      rs.post_poi(poi)
    end

    rs.status_update
  end

  def rails_service(token)
    RailsService.new(token) #"http://localhost:3000/")
  end
end
