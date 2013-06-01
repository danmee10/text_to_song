class SongsController < ApplicationController

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(params[:song])
    @scaffold = Scaffold.new(params[:song][:original_text], @song.id)
    # @song.lines = @scaffold.lines
    @song.stanzas = @scaffold.stanzas
    if @song.save
      redirect_to edit_song_path(@song.id)
    else
      flash[:error] = "Please enter text"
      redirect_to root_path
    end
  end

  def edit
    @song = Song.find(params[:id])
  end
end
