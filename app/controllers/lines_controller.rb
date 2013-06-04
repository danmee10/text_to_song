class LinesController < ApplicationController

  def update
    @new_word = Word.objectify(params[:line][:words])
    @line = Line.find(params[:id])
    @stanza = Stanza.find_by_id(@line.stanza_id)
    @song = Song.find_by_id(@stanza.song_id)
    @line_word = Lineword.find(@line.id, @word.id)
    @Line_word.word_id = @new_word.id
    # current line, old word, new word to replace
    # current_line find the old word
    # remove the relationship


    fail
    redirect_to edit_song_path(@song.id)
  end
end
