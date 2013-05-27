class Song #< ActiveRecord::Base
  include Syllablizer
  include RhymingEngine
  include Formatter
  attr_reader :lyrics, :text

  def initialize(text)
    @lyrics = songify(text)
    @text = text
  end

private
  def songify(text)
    syllablized_text = syllablize(text)
    rhymed_text = rhyming_engine(syllablized_text)
    format_text(rhymed_text)
  end
end
