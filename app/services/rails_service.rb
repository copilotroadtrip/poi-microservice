class RailsService

  def conn
    @_conn||= Faraday.new("http://localhost:3000") do |f|
    f.adapter Faraday.default_adapter
  end

  def post_leg(leg)
    leg_json = LegSerializer.new(leg).to_json

    conn.post("/api/v1/trip_legs") do |req|
      req.body = leg_json
    end
  end
end
