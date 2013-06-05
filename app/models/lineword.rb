class Lineword < ActiveRecord::Base
  attr_accessible :word_id, :line_id, :word_index



  belongs_to :line
  belongs_to :word

  def self.find(line_id, word_id)
    find_by_line_id_and_word_id(line_id, word_id)
  end

  def replace_word_with(new_word_id)

  end
end
