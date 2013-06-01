class SongsController < ApplicationController

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(params[:song])
    if @song.save
      redirect_to edit_song_path(@song.id)
    else
      fail
      flash[:error] = "Please enter text"
      redirect_to root_path
    end
  end

  def edit
    @song = Song.find(params[:id])
  end
end
