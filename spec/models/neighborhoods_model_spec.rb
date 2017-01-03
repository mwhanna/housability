require "rails_helper"

RSpec.describe Border, :type => :model do
	before(:all) do
		borders = CSV.read("./datafiles/neighborhoods.csv")
		borders.shift

		numrows = 0
		borders.each do |row|
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
	            end 
        	}

  			finalCoords = Array.new
  			(0...6).step(5).each do |a|
    			finalCoords.push(tempCoords[a])
			end
			Border.create(name: name, score: score, centre: centre, coords: finalCoords)
			break if numrows == 2
			numrows = numrows + 1
		end
  	end

  	after(:all) do
  		Border.delete_all
  	end

	it "should have three borders" do
	    length = Border.all.length
	    expect(length).to eq(3)
	end

	it "should not have a dummy record" do
	    dummy = Border.where(name: "dummy")
	    expect(dummy).to eq([])
	end

	it "should have correct values for border #1" do
	    border1 = Border.all[0]
	    expect(border1.name).to eq("Arbutus-Ridge")
	    expect(border1.score).to eq(1)
	    expect(border1.centre).to eq("49.249105,-123.1615")
	    expect(border1.coords).to eq(["49.257482642589025,-123.16407742426055", "49.25735804099439,-123.15791253524193"])
	end

	it "should have correct values for border #2" do
	    border2 = Border.all[1]
	    expect(border2.name).to eq("Shaughnessy")
	    expect(border2.score).to eq(1)
	    expect(border2.centre).to eq("49.24776,-123.139187")
	    expect(border2.coords).to eq(["49.23456853651252,-123.15528417444278", "49.239694734320466,-123.15498747587209"])
	end

	it "should have correct values for border #3" do
	    border3 = Border.all[2]
	    expect(border3.name).to eq("Riley Park")
	    expect(border3.score).to eq(1)
	    expect(border3.centre).to eq("49.24329,-123.102459")
	    expect(border3.coords).to eq(["49.23315910836121,-123.10565550196236", "49.233436011854984,-123.11343662742946"])
	end
end