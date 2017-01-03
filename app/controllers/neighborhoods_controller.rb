class NeighborhoodsController < ApplicationController
  require 'json'
  def index
    @borders = Border.all
    respond_to do |format|
       format.json { render :json => @borders }
     end
  end
end
