# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Seeding"

options_hash = {col_sep: ",", headers: true,
  header_converters: :symbol, converters: :numeric}

pois = CSV.open('db/data/all_poi.csv', options_hash)

poi_hashes = pois.map{ |row| row.to_hash }

poi_hashes.each do |hash|
  Poi.create!(ne_latitude: hash[:nelat],
             ne_longitude: hash[:nelng],
             sw_latitude: hash[:swlat],
             sw_longitude: hash[:swlng],
             name: hash[:name],
             population: hash[:population],
             state: hash[:state],
             land_area: hash[:land_area],
             total_area: hash[:total_area])

end
