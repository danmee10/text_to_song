class Song #< ActiveRecord::Base
  include Syllablizer
  include RhymingEngine
  attr_reader :lyrics, :text

  def initialize(text)
    @lyrics = songify(text)
    @text = text
  end

private
  def songify(text)
    syllablized_text = syllablize(text)
    rhyming_engine(syllablized_text)
  end
end
