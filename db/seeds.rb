# To seed the database, run "rake db:seed"

require 'csv'


##########################################
# Seed Crime Data
##########################################

 puts "Seeding Crimes table"

 crime = CSV.read("./datafiles/crime.csv")
 crime.shift

 crime.each do |row|
   desc = row[0]
   address = row[3].split(' ', 2)

   if desc == 'Commercial Break and Enter'
   	if address[0].end_with? "XX"
 			address[0] = address[0].gsub('X','0')
 		end

 		address =  address[0] + ' ' + address[1] + ', VANCOUVER, BC, CANADA'
 		coordinates = Geokit::Geocoders::MultiGeocoder.geocode(address)
 		crime = Crime.find_by(:latitude => coordinates.lat, :longitude => coordinates.lng)

 		if crime
 			crime.update(occurrences: crime.occurrences + 1)
 		else
 			Crime.create(description: desc, latitude: coordinates.lat, longitude: coordinates.lng, occurrences: 1)
 		end

 		# Delay to make sure that 10 requests per sec. is not exceeded
 	   sleep(0.15)
 	end
 end

 puts "Crimes table seeded."

 # To test seeding of crimes into database
 # Crime.find_each do |crime|
 # 	puts crime.description + " " + crime.latitude.to_s + " " +  crime.longitude.to_s + " " + crime.occurrences.to_s
 # end

 ##########################################
 # Seed School Data
 ##########################################

 puts "Seeding Schools table."

 schools = CSV.read("./datafiles/schools.csv")
 schools.shift

 schools.each do |row|
   name = row[0]
   lat = row[1]
   lng = row[2]
   addr = row[3]
   website = row[4]

 	School.create(name: name, latitude: lat, longitude: lng, address: addr, website: website)

 end

 puts "Schools table seeded."

 # To test seeding of schools into database
 # School.find_each do |school|
 # 	puts school.name + " " + school.latitude.to_s + " " +  school.longitude.to_s + " " + school.address + " " + school.website
 # end

 ##########################################
 # Seed Park Data
 ##########################################

 puts "Seeding Parks table."

 parks = CSV.read("./datafiles/parks.csv")
 parks.shift

 parks.each do |row|
   name = row[0]
   lat = row[1]
   lng = row[2]
   addr = row[3]
   website = row[4]

 	Park.create(name: name, latitude: lat, longitude: lng, address: addr, website: website)

 end

 puts "Parks table seeded."

 # To test seeding of schools into database
 # Park.find_each do |park|
 # 	puts park.name + " " + park.latitude.to_s + " " +  park.longitude.to_s + " " + park.address + " " + park.website
 # end

 ##########################################
 # Seed Rapid Transit Stations Data
 ##########################################

 puts "Seeding Stations table."

 stations = CSV.read("./datafiles/stations.csv")
 stations.shift

 stations.each do |row|
   name = row[0]
   lat = row[1]
   lng = row[2]

 	Station.create(name: name, latitude: lat, longitude: lng)

 end

 puts "Stations table seeded."

 # To test seeding of stations into database
 # Station.find_each do |station|
 # 	puts station.name + " " + station.latitude.to_s + " " +  station.longitude.to_s
 # end

 ##########################################
 # Seed Libraries Data
 ##########################################

 puts "Seeding Libraries table."

 libraries = CSV.read("./datafiles/libraries.csv")
 libraries.shift

 libraries.each do |row|
   name = row[0]
   lat = row[1]
   lng = row[2]
   addr = row[3]
   website = row[4]

 	Library.create(name: name, latitude: lat, longitude: lng, address: addr, website: website)

 end


 puts "Libraries table seeded."

 # To test seeding of libraries into database
 # Library.find_each do |library|
 # 	puts library.name + " " + library.latitude.to_s + " " +  library.longitude.to_s + " " + library.address + " " + library.website
 # end

 ##########################################
 # Seed Community Centre Data
 ##########################################

 puts "Seeding Community Centres table."

 communityCentres = CSV.read("./datafiles/communitycentres.csv")
 communityCentres.shift

 communityCentres.each do |row|
   name = row[0]
   lat = row[1]
   lng = row[2]
   addr = row[3]
   website = row[4]

 	CommunityCentre.create(name: name, latitude: lat, longitude: lng, address: addr, website: website)
 end

 puts "Community Centres table seeded."

 # To test seeding of community centres into database
 # CommunityCentre.find_each do |communityCentre|
 # 	puts communityCentre.name + " " + communityCentre.latitude.to_s + " " +  communityCentre.longitude.to_s + " " + communityCentre.address + " " + communityCentre.website
 # end

##########################################
# Seed Borders Data
##########################################

puts "Seeding Borders table"

neighborhoods = CSV.read('./datafiles/neighborhoods.csv')
neighborhoods.shift

neighborhoods.each do |row|
  name = row[0]
  (lt,ln) = row[1].split(';')
  centre = "#{lt.to_f},#{ln.to_f}"
  border = "#{row[2]}"
  score = 1
  ary = Array.new
  tempCoords = Array.new
  border.each_line(' ') {|b| ary.push(b)}
  # Comment out to seed Neighborhoods
  ary.each {|a| (lat,lon) = a.split(';')
            lat = lat.strip
            lon = lon.strip
            if "#{lat.to_f}".length > 3
              temp = "#{lat.to_f},#{lon.to_f}"
              tempCoords.push(temp)
            end }

  finalCoords = Array.new
  (0...tempCoords.length).step(5).each do |a|
    finalCoords.push(tempCoords[a])
  end

  Border.create(name: name, score: score, centre: centre, coords: finalCoords)
end
puts "Borders table seeded."

# To test seeding of neighborhoods into database
#Neighborhood.find_each do |neighborhood|
# 	puts neighborhood.latitude
#end

#Border.find_each do |a|
#  puts a.name
#  puts a.coords
#end
