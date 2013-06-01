class SongsController < ApplicationController

  def new
    @text = Song.new(text)
  end

  def edit
    @song = Song.new(params[:text])
  end
end
