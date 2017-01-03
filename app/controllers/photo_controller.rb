class PhotoController < ApplicationController
	def photos

		posts = {}
		lat = params[:lat]
		long = params[:lng]
		id = params[:id]
		if (lat != nil and long != nil)
			posts = Instagram.media_search(lat, long, {:count => 5})
		end
		if (id != nil)
			posts = Instagram.media_likes(id)
		end
		render :json => posts
	end

	def link
		link = params[:link]
		id = params[:id]
		like = params[:like]
		access_token = params[:access_token]
		if link == "false"
			current_user.update_attribute(:access_token, "")
			current_user.update_attribute(:instagram_user, "")
		end
		if (like != nil) 
			result = Instagram.like_media(id, {:access_token => access_token})
		end
		render :json => result
	end

	def unlike
		id = params[:id]
		access_token = params[:access_token]
		result = Instagram.unlike_media(id, {:access_token => access_token})
		render :json => result
	end
end
