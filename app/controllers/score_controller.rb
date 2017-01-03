class ScoreController < ApplicationController
  def index
  	lat = params[:lat]
  	long = params[:lng]
    comctr = params[:commcentres]
  	lib = params[:libraries]
  	park = params[:parks]
  	schools = params[:schools]
  	stns = params[:stations]
  	crms = params[:crimes]
  	radius = params[:radius]
  	ary = Array.new
  	ary = [comctr, lib, park, schools, stns, crms]
  	@score = score("#{lat},#{long}", ary, radius.to_i)
  	respond_to do |format|
  		format.json { render :json => @score }
  	end
  end

  private
  def score(loc, check, radius)
  	total = 0;
  	totalPlaces = 0;
  	places = Array.new(Array.new());
  	for i in 0..4
  		if check[i] == "on"
  			list = getPlace(loc, radius, i);
  			s = subScore(loc, radius, list);
  			totalPlaces += list.length;
  			total += list.length * s unless list.length == nil || s == nil
  		end
  	end
  	if check[5] == "on"
  		list = getPlace(loc, radius, 5);
  		crime = subScore(loc, radius, list);
  		crime = 9 - crime;
  		totalPlaces += list.length;
  		total += list.length * crime unless list.length == nil || crime == nil
  	end

  	final = total/totalPlaces
    return final.round(1)
  end


  def getPlace(loc, radius, category)
  	a = Array.new
   		case category
   			# community centers
   			when 0
  				CommunityCentre.find_each do |commcentre|
  					location = "#{commcentre.latitude},#{commcentre.longitude}"
  					d = distance(loc, location)
  					if d <= radius
  						a << d
  					end
  				end
  				return a

   			# libraries
   			when 1
  				Library.find_each do |library|
  					location = "#{library.latitude},#{library.longitude}"
  					d = distance(loc, location)
  					if d <= radius
  						a << d
  					end
  				end
  				return a

   			# schools
   			when 2
  				School.find_each do |school|
  					location = "#{school.latitude},#{school.longitude}"
  					d = distance(loc, location)
  					if d <= radius
  						a << d
  					end
  				end
  				return a

   			# stations
   			when 3
  				Station.find_each do |station|
  					location = "#{station.latitude},#{station.longitude}"
  					d = distance(loc, location)
  					if d <= radius
  						a << d
  					end
  				end
  				return a

   			# parks
   			when 4
  				Park.find_each do |park|
  					location = "#{park.latitude},#{park.longitude}"
  					d = distance(loc, location)
  					if d <= radius
  						a << d
  					end
  				end
  				return a

   			# crimes
   			when 5
  				Crime.find_each do |crime|
  					location = "#{crime.latitude},#{crime.longitude}"
  					d = distance(loc, location)
  					if d <= radius
  						a << d
  					end
  				end
  				return a
  			end
  end

  def subScore(loc, radius, list)
  	i = list.length
  	total = 0
  	for n in 0..i
  		loc2 = list[n];
  		if(loc2 != nil)
  			total += calcScore(loc2, radius)
  		end
  	end
  	return total/i unless i == 0
  end

  def distance(loc1, loc2)
   if(loc1 != nil && loc2 != nil)
   	(lat1, lon1) = loc1.split(',')
   	(lat2, lon2) = loc2.split(',')
   	lat1 = lat1.to_f
   	lon1 = lon1.to_f
   	lat2 = lat2.to_f
   	lon2 = lon2.to_f
   	dLat = (lat2 - lat1) * Math::PI / 180;
   	dLon = (lon2 - lon1) * Math::PI / 180;
   	b = Math.sin(dLat/2) * Math.sin(dLat/2) +
  		 	Math.cos(lat1 * Math::PI / 180) * Math.cos(lat2 * Math::PI / 180) *
  		 	Math.sin(dLon/2) * Math.sin(dLon/2);
   	c = 2 * Math.atan2(Math.sqrt(b), Math.sqrt(1-b));
   	return 6371 * c; # Multiply by 6371 to get Kilometers
  	end
  end

  def calcScore(d, radius)
  	if(d != nil && radius != nil)
  		return (-11**(d / radius)) + 11;
  	end
  end
end
