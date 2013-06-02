class AltSpelling < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :word

  def spelling
    alt_spelling
  end

  def syllable_count
    word.syllable_count
  end
end
