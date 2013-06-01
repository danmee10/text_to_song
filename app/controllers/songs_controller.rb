class SongsController < ApplicationController

  def new
    @song = Song.new
  end

  def create
    @song = Song.create(params[:song])
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

  def update
    @song = Song.find(params[:id])
    if params[:song][:syllables_per_line].to_i != 0 && params[:song][:lines_per_stanza].to_i != 0
      @scaffold = Scaffold.new(@song.original_text, @song.id, params[:song][:syllables_per_line].to_i,
                                                              params[:song][:lines_per_stanza].to_i)
      @song.stanzas = @scaffold.stanzas
      if @song.save
        redirect_to edit_song_path(@song.id)
      else
        flash[:error] = "ERROR!!!"
        redirect_to edit_song_path(@song.id)
      end
    else
      flash[:error] = "ERROR!!!"
      redirect_to edit_song_path(@song.id)
    end
  end
end
