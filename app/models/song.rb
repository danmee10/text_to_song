class Song < ActiveRecord::Base

  attr_accessor :lines_per_stanza, :syllables_per_line
  attr_accessible :original_text

  has_many :stanzas
  has_many :lines, :through => :stanzas
  has_many :words, :through => :lines

  validates :original_text, :presence => true

end
