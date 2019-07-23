class RailsService

  def initialize(token, url = "https://copilot-backend.herokuapp.com/")
    @token = token
    @url = url
  end

  def conn
    @_conn||= Faraday.new(@url) do |f|
      f.adapter Faraday.default_adapter
      f.headers['Content-Type'] = 'application/json'
    end
  end

  def post_leg(leg)
    leg_json = LegSerializer.new(leg, @token).to_json

    conn.post("/api/v1/trip_legs", json(leg_json))
  end

  def json(hash)
    JSON.generate(hash)
  end

  def post_poi(poi)
    poi_json = PoiSerializer.new(poi, @token).to_json

    conn.post("/api/v1/trip_pois", json(poi_json))
  end

  def status_update
    conn.patch("/api/v1/trips", json({token: @token, status: "ready"}))
  end
end
