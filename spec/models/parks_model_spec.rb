require "rails_helper"

RSpec.describe Park, :type => :model do
	before(:all) do
		parks = CSV.read("./datafiles/parks.csv")
		parks.shift

		numrows = 0
		parks.each do |row|
		   	name = row[0]
		   	lat = row[1]
		   	lng = row[2]
		   	addr = row[3]
		   	website = row[4]
		 	Park.create(name: name, latitude: lat, longitude: lng, address: addr, website: website)
			break if numrows == 2
			numrows = numrows + 1
		end
  	end

  	after(:all) do
  		Park.delete_all
  	end

	it "should have three parks" do
	    length = Park.all.length
	    expect(length).to eq(3)
	end

	it "should not have a dummy record" do
	    dummy = Park.where(name: "dummy")
	    expect(dummy).to eq([])
	end

	it "should have correct values for park #1" do
	    park1 = Park.all[0]
	    expect(park1.name).to eq("Aberdeen Park")
	    expect(park1.latitude).to eq(49.2347)
	    expect(park1.longitude).to eq(-123.0273)
	    expect(park1.address).to eq("3525 Foster Av")
	    expect(park1.website).to eq("http://www.city.vancouver.bc.ca/parks/parks/index.htm")
	end

	it "should have correct values for park #2" do
	    park2 = Park.all[1]
	    expect(park2.name).to eq("Adanac Park")
	    expect(park2.latitude).to eq(49.2762)
	    expect(park2.longitude).to eq(-123.0255)
	    expect(park2.address).to eq("1025 Boundary Road")
	    expect(park2.website).to eq("http://cfapp.vancouver.ca/parkfinder_wa/index.cfm?fuseaction=FAC.ParkDetails&park_id=65")
	end

	it "should have correct values for park #3" do
	    park3 = Park.all[2]
	    expect(park3.name).to eq("Alexandra Park")
	    expect(park3.latitude).to eq(49.2854)
	    expect(park3.longitude).to eq(-123.1422)
	    expect(park3.address).to eq("1755 Beach Av")
	    expect(park3.website).to eq("http://cfapp.vancouver.ca/parkfinder_wa/index.cfm?fuseaction=FAC.ParkDetails&park_id=199")
	end
end