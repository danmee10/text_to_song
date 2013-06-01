class Stanza < ActiveRecord::Base
  attr_accessible :song_id

  belongs_to :song
  has_many :lines
  has_many :words, :through => :lines
end
