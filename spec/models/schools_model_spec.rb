require "rails_helper"

RSpec.describe School, :type => :model do
	before(:all) do
		schools = CSV.read("./datafiles/schools.csv")
		schools.shift

		numrows = 0
		schools.each do |row|
		   	name = row[0]
		   	lat = row[1]
		   	lng = row[2]
		   	addr = row[3]
		   	website = row[4]
		 	School.create(name: name, latitude: lat, longitude: lng, address: addr, website: website)
			break if numrows == 2
			numrows = numrows + 1
		end
  	end

  	after(:all) do
  		School.delete_all
  	end

	it "should have three schools" do
	    length = School.all.length
	    expect(length).to eq(3)
	end

	it "should not have a dummy record" do
	    dummy = School.where(name: "dummy")
	    expect(dummy).to eq([])
	end

	it "should have correct values for school #1" do
	    school1 = School.all[0]
	    expect(school1.name).to eq("King George Sec.")
	    expect(school1.latitude).to eq(49.2898)
	    expect(school1.longitude).to eq(-123.1364)
	    expect(school1.address).to eq("1755 Barclay St")
	    expect(school1.website).to eq("http://www.vsb.bc.ca/schools/king-george")
	end

	it "should have correct values for school #2" do
	    school2 = School.all[1]
	    expect(school2.name).to eq("Britannia Sec.")
	    expect(school2.latitude).to eq(49.2752)
	    expect(school2.longitude).to eq(-123.0719)
	    expect(school2.address).to eq("1001 Cotton Drive")
	    expect(school2.website).to eq("http://www.vsb.bc.ca/schools/britannia-secondary")
	end

	it "should have correct values for school #3" do
	    school3 = School.all[2]
	    expect(school3.name).to eq("Magee Sec.")
	    expect(school3.latitude).to eq(49.2286)
	    expect(school3.longitude).to eq(-123.1515)
	    expect(school3.address).to eq("6360 Maple St")
	    expect(school3.website).to eq("http://www.vsb.bc.ca/schools/magee")
	end
end