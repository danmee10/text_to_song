class Song #< ActiveRecord::Base
  include Syllablizer
  include RhymingEngine
  include Formatter
  attr_reader :lyrics, :text
  # attr_reader :text

  def initialize(text)
    @text = text
    @lyrics = songify(text)
  end

  # def lyrics
  #   @lyrics ||= songify(text)
  # end

private
  def songify(text)
    syllablized_text = syllablize(text)
    rhymed_text = rhyming_engine(syllablized_text)
    # format_text(rhymed_text)
  end
end


# it "lyrics are songified text" do
#   song_text = "our song text"
#   song = Song.new(song_text)
#   song.should_receive(:songify).with(song_text).and_return("Sing me a song")

#   expect(song.lyrics).to eq("Sing me a song")

# end
