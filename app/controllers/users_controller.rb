class UsersController < ApplicationController
	def current_user_token
	    if current_user != nil 
	    	render json: {user_id: current_user.id, access_token: current_user.access_token, instagram_user: current_user.instagram_user}
		else
	    	render json: {access_token: "", instagram_user: ""}
		end
	end
end