class Scaffold
  attr_reader :lines, :stanzas
  attr_accessor :lines_per_stanza, :syllables_per_line

  def initialize(text, song_id, syllables_per_line=10, lines_per_stanza=4)
    @song_id = song_id
    self.syllables_per_line = syllables_per_line
    self.lines_per_stanza = lines_per_stanza
    @lines = text_to_lines(text)
    @stanzas = lines_to_stanzas(@lines)
  end

  def text_to_lines(text)
    words = Word.text_to_word_objects(text)
    line = Line.create
    lines_array = []
    words.collect do |word|


      if (line.syllables + word.syllable_count) <= syllables_per_line
        line.words << word
      else
        lines_array << line
        line = Line.create
        line.words = [word]
      end

      if word = words.last
        lines_array << line
      end


    end
    lines_array.uniq
  end

  def lines_to_stanzas(lines)
    stanzas_array = []
    lines.each_slice(lines_per_stanza).collect do |four_line_group|
      stanza = Stanza.create(song_id: @song_id)
      four_line_group.each do |line|
        stanza.lines << line
      end
      stanzas_array << stanza
    end
    stanzas_array
  end
end
