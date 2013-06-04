class Api::LinesController < ApplicationController

  def update
    @old_word = Word.find(params[:old_word].to_i)
    @new_word = Word.objectify(params[:new_word])
    @line = Line.find(params[:id])
    # @stanza = Stanza.find_by_id(@line.stanza_id)
    # @song = Song.find_by_id(@stanza.song_id)
    @line_word = Lineword.find(@line.id, @old_word.id)
    @line_word.word_id = @new_word.id
    @line_word.save


    respond_to do |format|
      format.json { render json: @payload }
      format.xml { render xml: @word }
    end
  end
end
