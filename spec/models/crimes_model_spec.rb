require "rails_helper"

RSpec.describe Crime, :type => :model do
	before(:all) do
    	crimes = CSV.read("./datafiles/crime.csv")
		crimes.shift

		numrows = 0
		crimes.each do |row|
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
		 		break if numrows == 3
 				numrows = numrows + 1
 			end
 		end
  	end

  	after(:all) do
  		Crime.delete_all
  	end

	it "should have three crimes" do
	    length = Crime.all.length
	    expect(length).to eq(3)
	end

	it "should have three crimes" do
	    dummy = Crime.where(description: "dummy")
	    expect(dummy).to eq([])
	end

	it "should have correct values for crime #1" do
	    comm1 = Crime.all[0]
	    expect(comm1.description).to eq("Commercial Break and Enter")
	    expect(comm1.latitude).to eq(49.2413003)
	    expect(comm1.longitude).to eq(-123.1369066)
	    expect(comm1.occurrences).to eq(1)
	end

	it "should have correct values for crime #2" do
	    comm2 = Crime.all[1]
	    expect(comm2.description).to eq("Commercial Break and Enter")
	    expect(comm2.latitude).to eq(49.2772155)
	    expect(comm2.longitude).to eq(-123.1299523)
	    expect(comm2.occurrences).to eq(2)
	end

	it "should have correct values for crime #3" do
	    comm3 = Crime.all[2]
	    expect(comm3.description).to eq("Commercial Break and Enter")
	    expect(comm3.latitude).to eq(49.2794594)
	    expect(comm3.longitude).to eq(-123.0997195)
	    expect(comm3.occurrences).to eq(1)
	end
end