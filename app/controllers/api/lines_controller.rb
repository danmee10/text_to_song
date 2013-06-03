class Api::LinesController < ApplicationController

  def update
    @line = Line.find(params[:id])
    fail
    @line.words = params[:words]
    respond_to do |format|
      format.json { render json: @payload }
      format.xml { render xml: @word }
    end
  end
end
