class SearchController < ApplicationController
	require 'json'
	def index
		@searches = Search.order(score: :desc)
		respond_to do |format|
			format.json { render :json => @searches }
		end
	end
end
