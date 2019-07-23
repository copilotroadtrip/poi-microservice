require 'sinatra/base'

class PoiServiceApp < Sinatra::Base
  set :root, File.expand_path("..",__dir__)

  post '/api/v1/build_trip' do
    body = JSON.parse(request.body.read, symbolize_names: true)
    # 

    ts = TripService.new(body[:steps], body[:token])
    rs = rails_service(body[:token])
    ts.legs.each do |leg|
      rs.post_leg(leg)
    end

    ts.pois.each do |poi|
      rs.post_poi(poi)
    end

    rs.status_update
  end

  def rails_service(token)
    RailsService.new(token) #"http://localhost:3000/")
  end
end
