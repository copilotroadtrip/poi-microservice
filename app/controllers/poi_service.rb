require 'sinatra/base'

class PoiServiceApp < Sinatra::Base
  set :root, File.expand_path("..",__dir__)

  post '/api/v1/build_trip' do
    body = JSON.parse(request.body.read, symbolize_names: true)

    ts = TripService.new(body[:steps], body[:token])

    ts.legs.each do |leg|
      rails_service.post_leg(leg)
    end

    ts.pois.each do |poi|
      rails_service.post_poi(poi)
    end
  end

  def rails_service
    @_rails_service = RailsService.new
  end
end
