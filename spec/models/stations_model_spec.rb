require "rails_helper"

RSpec.describe Station, :type => :model do
	before(:all) do
		stations = CSV.read("./datafiles/stations.csv")
		stations.shift

		numrows = 0
		stations.each do |row|
		   	name = row[0]
		   	lat = row[1]
		   	lng = row[2]
		 	Station.create(name: name, latitude: lat, longitude: lng)
			break if numrows == 2
			numrows = numrows + 1
		end
  	end

  	after(:all) do
  		Station.delete_all
  	end

	it "should have three stations" do
	    length = Station.all.length
	    expect(length).to eq(3)
	end

	it "should not have a dummy record" do
	    dummy = Station.where(name: "dummy")
	    expect(dummy).to eq([])
	end

	it "should have correct values for station #1" do
	    station1 = Station.all[0]
	    expect(station1.name).to eq("WATERFRONT")
	    expect(station1.latitude).to eq(49.2860754854534)
	    expect(station1.longitude).to eq(-123.111738155627)
	end

	it "should have correct values for station #2" do
	    station2 = Station.all[1]
	    expect(station2.name).to eq("BURRARD")
	    expect(station2.latitude).to eq(49.2858601496795)
	    expect(station2.longitude).to eq(-123.119972336831)
	end

	it "should have correct values for station #3" do
	    station3 = Station.all[2]
	    expect(station3.name).to eq("GRANVILLE")
	    expect(station3.latitude).to eq(49.283637687868)
	    expect(station3.longitude).to eq(-123.116404027665)
	end
end