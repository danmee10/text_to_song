class Word < ActiveRecord::Base
  # attr_accessible :title, :body
  validates :spelling, presence: :true
  validates_uniqueness_of :spelling, :scope => :part_of_speech
  validates_uniqueness_of :part_of_speech, :scope => :spelling

  has_many :synonyms
  has_many :friends, :through => :synonyms
end
