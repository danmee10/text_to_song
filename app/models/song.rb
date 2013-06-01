class Song < ActiveRecord::Base
  include Scaffolder
  include RhymingEngine
  include Formatter
  attr_reader :text, :lyrics
  attr_accessor :lines_per_stanza, :syllables_per_line
  attr_accessible :original_text

  has_many :stanzas
  has_many :lines, :through => :stanzas
  has_many :words, :through => :lines

  validates :original_text, :presence => true
  # def initialize(lines_per_stanza=4, syllables_per_line=10)
  #   @text = text
  #   @lines_per_stanza = lines_per_stanza
  #   @syllables_per_line = syllables_per_line
  # end

  def lyrics
    break_down(original_text)
  end

private
  def break_down(text)
    if text && song_material?(text)
      syllablized_text = lines_and_stanzas(text)
      # rhymed_text = rhyming_engine(syllablized_text)
      # format_text(rhymed_text)
    elsif text
      [[normalize_text(text)]]
    end
  end

  def song_material?(text)
    syllable_count(text) > SYLLABLES_PER_LINE
  end
end
