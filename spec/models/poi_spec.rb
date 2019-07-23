require 'spec_helper'

RSpec.describe Poi, type: :model do
  before :each do
    @poi_1 = create(:poi,
      sw_latitude: 0, sw_longitude: 0,ne_latitude: 2, ne_longitude: 2, population: 1_000
    )
    @poi_2 = create(:poi,
      sw_latitude: 1, sw_longitude: 1,ne_latitude: 3, ne_longitude: 3, population: 2_000
    )
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :ne_latitude }
    it { should validate_presence_of :ne_longitude }
    it { should validate_presence_of :sw_latitude }
    it { should validate_presence_of :sw_longitude }
    it { should validate_presence_of :population }
    it { should validate_presence_of :state }
    it { should validate_presence_of :land_area }
    it { should validate_presence_of :total_area }
  end
  #
  # describe 'Relationships' do
  #   it { should have_many :trip_pois }
  #   it { should have_many(:trips).through(:trip_pois) }
  # end
  describe 'Instance Methods' do
    describe 'center' do
      it 'returns a Coordinate object' do
        center = @poi_1.center
        expect(center).to be_a(Coordinate)
        expect(center.lat).to eq(1)
        expect(center.lng).to eq(1)
      end
    end
  end

  describe 'Class Methods' do

    describe 'poi_at_location' do
      it 'can return a single poi' do
        single_poi = Poi.poi_at_location(0.5, 0.5)
        expect(single_poi.length).to eq(1)
        expect(single_poi[0]).to eq(@poi_1)
      end

      it 'can return multiple poi' do
        multiple_poi = Poi.poi_at_location(1.5, 1.5)
        expect(multiple_poi.length).to eq(2)

        expect(multiple_poi).to include(@poi_1)
        expect(multiple_poi).to include(@poi_2)

      end

      it 'can return no poi' do
        zero_poi = Poi.poi_at_location(-1,-1)
        expect(zero_poi).to eq(nil)
      end

      it 'returns poi if on edge' do
        one_poi = Poi.poi_at_location(0,0)
        expect(one_poi.length).to eq(1)
        expect(one_poi[0]).to eq(@poi_1)
      end
    end

    describe 'population_at_location' do
      it 'returns population of a pois' do
        population_1 = Poi.population_at_location(0.5, 0.5)
        expect(population_1).to eq(1_000)

        population_2 = Poi.population_at_location(1.5, 1.5)
        expect(population_2).to eq(3_000)
      end

      it 'returns 0 if outside of any pois' do
        population = Poi.population_at_location(-1, -1)
        expect(population).to eq(0)
      end
    end
  end
end
