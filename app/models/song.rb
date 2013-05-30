class Song #< ActiveRecord::Base
  include Syllablizer
  include RhymingEngine
  include Formatter
  attr_reader :lyrics, :text

  def initialize(text)
    @text = text
    @lyrics = songify(text)
  end

private
  def songify(text)
    if text && song_material?(text)
      syllablized_text = syllablize(text)
      rhymed_text = rhyming_engine(syllablized_text)
      # format_text(rhymed_text)
    else
      [[normalize_text(text)]]
    end
  end

  def song_material?(text)
    syllable_count(text) > SYLLABLES_PER_LINE
  end
end
