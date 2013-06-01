class Word < ActiveRecord::Base
  attr_accessible :spelling, :syllable_count, :checked_to_dictionary


  validates :spelling, presence: :true
  validates_uniqueness_of :spelling, :scope => :part_of_speech
  validates_uniqueness_of :part_of_speech, :scope => :spelling

  has_and_belongs_to_many :lines

  has_many :synonym_relationships
  has_many :synonyms, :through => :synonym_relationships
  has_many :rhyming_relationships
  has_many :rhymes, :through => :rhyming_relationships


  def to_s
    spelling
  end
end
