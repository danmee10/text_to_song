class Line < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :stanza
  has_and_belongs_to_many :words
  has_and_belongs_to_many :alt_spellings



  def syllables
    syllables = words.collect do |word|
      word.syllable_count
    end
    syllables.sum
  end
end
