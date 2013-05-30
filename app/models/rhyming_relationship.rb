class RhymingRelationship < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :word
  belongs_to :rhyme, :class_name => "Word"
end
