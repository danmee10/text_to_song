class LinesController < ApplicationController

  def update
    @line = Line.find(params[:id])
    @stanza = Stanza.find_by_id(@line.stanza_id)
    @song = Song.find_by_id(@stanza.song_id)
    @line.words[params[:line][:max_syllables].to_i] = params[:line][:words]
    fail
    redirect_to edit_song_path(@song.id)
  end
end
