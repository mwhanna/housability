require 'csv'

class PagesController < ApplicationController
	skip_before_filter :verify_authenticity_token
	def housability
		code = params[:code]
		if (current_user != nil)
			if (current_user.access_token == nil || current_user.access_token == "")
				if (code != nil)
					access_token = Instagram.get_access_token(code, :redirect_uri => "https://housability.herokuapp.com/housability")
					current_user.update_attribute(:access_token, access_token.access_token)
					current_user.update_attribute(:instagram_user, access_token.user.username)
					access_token = current_user.access_token
				end
			end
		else
			access_token = ""
		end

		@searches = Search.all
		if current_user != nil
			if (current_user.access_token == nil || current_user.access_token == "")
				@linked = "false"
			else
				@linked = "true"
			end
		end


		# HERE::: User Searches
		address = params[:data_value]

		# LONG AND LAT HERE
		longitude = params[:longitude]
		latitude = params[:latitude]
		userid = params[:userid]
		score = params[:score]

		duplicate = "false"
		if (address != nil)
			Search.all.each do |search|
				if (search.address == address) && (search.user_id.to_i == userid.to_i)
					duplicate = "true"
				end
			end
			if duplicate == "false"
				search = Search.new(:address => address, :latitude => latitude, :longitude => longitude, :score => score, :user_id => userid)
				search.save
			end
		end

		userid = params[:user_id]

		params.each do |key, val|
			Search.all.each do |tempsearch|
				if (key.to_i == tempsearch.id)
					tempsearch.favorite = true
					tempsearch.save
				end
			end
		end
		# YOOOOOOOOOO Kenneth. These are the checkboxes
		commcentres = params[:commcentres]
		libraries = params[:libraries]
		schools = params[:schools]
		stations = params[:stations]
		parks = params[:parks]
		crimes = params[:crimes]
		# This is the radio button.
		distance = params[:distance]
		puts commcentres
	end
end
