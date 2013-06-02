class AltSpelling < ActiveRecord::Base
  attr_accessible :alt_spelling, :word_id

  belongs_to :word
  has_and_belongs_to_many :lines


  def spelling
    alt_spelling
  end

  def syllable_count
    word.syllable_count
  end

  def self.find_or_create(alt_spelling, word_id)
    existing = AltSpelling.find_by_alt_spelling(alt_spelling)
    if existing
      existing
    else
      AltSpelling.create(alt_spelling: alt_spelling, word_id: word_id)
    end
  end
end
