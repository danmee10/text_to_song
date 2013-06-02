class Api::WordsController < ApplicationController

  def show
    @word = Word.find(params[:id])
    @payload = {word: @word, synonyms: @word.thesaurus_checker, rhymes: @word.rhyming_matches}
    respond_to do |format|
      format.json { render json: @payload }
      format.xml { render xml: @word }
    end
  end
end
