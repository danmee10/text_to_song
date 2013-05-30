class SynonymRelationship < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :word
  belongs_to :synonym, :class_name => "Word"
end
