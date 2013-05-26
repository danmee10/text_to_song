class SongsController < ApplicationController

  def new
    @text = ''
    @song = Song.new(params[:text])
  end
end
