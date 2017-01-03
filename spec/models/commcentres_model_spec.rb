require "rails_helper"

RSpec.describe CommunityCentre, :type => :model do
	before(:all) do
    	communityCentres = CSV.read("./datafiles/communitycentres.csv")
		communityCentres.shift

		numrows = 0
		communityCentres.each do |row|
		    name = row[0]
		    lat = row[1]
		    lng = row[2]
		    addr = row[3]
		    website = row[4]

 			CommunityCentre.create(name: name, latitude: lat, longitude: lng, address: addr, website: website)
 			break if numrows == 2
 			numrows = numrows + 1
 		end
  	end

  	after(:all) do
  		CommunityCentre.delete_all
  	end

	it "should have three community centres" do
	    length = CommunityCentre.all.length
	    expect(length).to eq(3)
	end

	it "should not have a dummy record" do
	    dummy = CommunityCentre.where(name: "dummy")
	    expect(dummy).to eq([])
	end

	it "should have correct values for community centre #1" do
	    comm1 = CommunityCentre.all[0]
	    expect(comm1.name).to eq("Britannia")
	    expect(comm1.latitude).to eq(49.2756)
	    expect(comm1.longitude).to eq(-123.0738)
	    expect(comm1.address).to eq("1661 Napier St")
	    expect(comm1.website).to eq("http://vancouver.ca/parks/cc/britannia/index.htm")
	end

	it "should have correct values for community centre #2" do
	    comm2 = CommunityCentre.all[1]
	    expect(comm2.name).to eq("Carnegie Centre")
	    expect(comm2.latitude).to eq(49.2811)
	    expect(comm2.longitude).to eq(-123.1001)
	    expect(comm2.address).to eq("401 Main St")
	    expect(comm2.website).to eq("http://vancouver.ca/commsvcs/CARNEGIECENTRE/index.htm")
	end

	it "should have correct values for community centre #3" do
	    comm3 = CommunityCentre.all[2]
	    expect(comm3.name).to eq("Roundhouse")
	    expect(comm3.latitude).to eq(49.2733)
	    expect(comm3.longitude).to eq(-123.1217)
	    expect(comm3.address).to eq("181 Roundhouse Mews")
	    expect(comm3.website).to eq("http://vancouver.ca/parks/cc/roundhouse/index.htm")
	end
end