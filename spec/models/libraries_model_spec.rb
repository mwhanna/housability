require "rails_helper"

RSpec.describe Library, :type => :model do
	before(:all) do
		libraries = CSV.read("./datafiles/libraries.csv")
		libraries.shift

		numrows = 0
		libraries.each do |row|
		   	name = row[0]
		   	lat = row[1]
		   	lng = row[2]
		   	addr = row[3]
		   	website = row[4]
		 	Library.create(name: name, latitude: lat, longitude: lng, address: addr, website: website)
			break if numrows == 2
			numrows = numrows + 1
		end
  	end

  	after(:all) do
  		Library.delete_all
  	end

	it "should have three libraries" do
	    length = Library.all.length
	    expect(length).to eq(3)
	end

	it "should not have a dummy record" do
	    dummy = Library.where(name: "dummy")
	    expect(dummy).to eq([])
	end

	it "should have correct values for library #1" do
	    library1 = Library.all[0]
	    expect(library1.name).to eq("Renfrew")
	    expect(library1.latitude).to eq(49.2524)
	    expect(library1.longitude).to eq(-123.043)
	    expect(library1.address).to eq("2969 E 22nd Av")
	    expect(library1.website).to eq("http://www.vpl.ca/branches/details/renfrew_branch")
	end

	it "should have correct values for library #2" do
	    library2 = Library.all[1]
	    expect(library2.name).to eq("Riley Park")
	    expect(library2.latitude).to eq(49.2497)
	    expect(library2.longitude).to eq(-123.1014)
	    expect(library2.address).to eq("3981 Main St")
	    expect(library2.website).to eq("http://www.vpl.ca/branches/details/riley_park_branch")
	end

	it "should have correct values for library #3" do
	    library3 = Library.all[2]
	    expect(library3.name).to eq("South Hill")
	    expect(library3.latitude).to eq(49.2295)
	    expect(library3.longitude).to eq(-123.0903)
	    expect(library3.address).to eq("6076 Fraser St")
	    expect(library3.website).to eq("http://www.vpl.ca/branches/details/south_hill_branch")
	end
end