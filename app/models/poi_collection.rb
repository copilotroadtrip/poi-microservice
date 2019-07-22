class PoiCollection

  # Collects POIs that are always the largest at any and all locations
  def initialize()
    @pois = {}
    @discarded = []
  end

  # Given a list of POIs
  def update(poi_list, coordinate_index)

    # `PoiSorter` determines which is largest as "keep"
    sorter = PoiSorter.new(poi_list)

    # Update the "discarded" list -- POIs that are NOT always the largest
    remove_discarded(sorter.discard)

    # Update info for largest POI, if not in discarded list
    poi = sorter.keep
    return if @discarded.index(poi)

    if @pois.keys.include?(poi)
      @pois[poi].update(coordinate_index)
    else
      @pois[poi] = PoiInfo.new(poi, coordinate_index)
    end

  end

  def remove_discarded(discard)
    @discarded.push(discard)
    @discarded = @discarded.uniq

    discard.each do |poi|
      @pois.delete(poi)
    end
  end

  # Finds coordinate index for a given POI
  def index(poi)
    if @pois.keys.include?(poi)
      return @pois[poi].start_coord
    else
      return nil
    end
  end

  # Returns all poi Info of "kept" pois
  # Info includes "start" and "end" coordinates of POI
  def ordered_pois
    @pois.values.sort_by{|poi_info| index(poi_info.poi)}
  end
end
