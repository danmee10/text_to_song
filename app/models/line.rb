class Line < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :stanza
  has_and_belongs_to_many :words


  def syllables
    syllables = words.collect do |word|
      word.syllable_count
    end
    syllables.sum
  end
end
