class PoiSorter
  attr_reader :keep, :discard

  # Given a list of POIs, find the largest
  def initialize(poi_list)
    @keep, @discard = sort_poi(poi_list)
  end

  def sort_poi(poi_list)
    # Only make db calls if there are any POIs
    if poi_list.length > 0
      keep = poi_list.order(population:"DESC").first
      discard = poi_list.where.not(id: keep.id)
    else
      keep = []
      discard = []
    end

    return [keep, discard]
  end

end
