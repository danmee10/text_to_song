class Line < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :stanza
  has_many :linewords
  has_many :words, :through => :linewords



  def syllables
    words = self.words.collect do |word|
      word.spelling
    end
    Word.syllable_count(words.join(" "))
  end
end
