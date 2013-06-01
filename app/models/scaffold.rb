class Scaffold
  include Formatter
  SYLLABLES_PER_LINE = 10
  attr_reader :lines, :stanzas

  def initialize(text, song_id)
    @song_id = song_id
    @lines = text_to_lines(text)
    @stanzas = lines_to_stanzas(@lines)
  end

  def text_to_lines(text)
    words = text_to_word_objects(text)
    line = Line.create
    lines_array = []
    words.collect do |word|
      if (line.syllables + word.syllable_count) <= SYLLABLES_PER_LINE
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
    lines.each_slice(4).collect do |four_line_group|
      stanza = Stanza.create(song_id: @song_id)
      four_line_group.each do |line|
        stanza.lines << line
      end
      stanzas_array << stanza
    end
    stanzas_array
  end

  def syllable_count(word)
    Odyssey.flesch_kincaid_re("#{word}", true)["syllable_count"]
  end

  def text_to_word_objects(text)
    text.split.collect do |word|
      existing_word = Word.find_by_spelling(word)
      if existing_word
        existing_word
      else
        Word.create(spelling: word, syllable_count: Odyssey.flesch_kincaid_re("#{word}", true)["syllable_count"])
      end
    end
  end
end

##working method...pre-object nonsense
  # def lines_and_stanzas(text)
  #   ##add condition that looks up synonyms with appropriate number of syllables
  #   ##when the last word in a line would push the total line syllables
  #   ##over the set abount --- lots to think about here (total reorganization)
  #   return [] unless text
  #   words_array = normalize_text(text)

  #   # return words_array if words_array.length == 1
  #   line = []
  #   syllables = 0
  #   words_array.inject([]) do |memo, word|
  #     syllables += syllable_count(word)
  #     if syllables <= SYLLABLES_PER_LINE
  #       line << word
  #     else
  #       syllables = syllable_count(word)
  #       memo << line
  #       line = [word]
  #     end
  #     if word == text.split.last && line != [word]
  #       memo << line
  #       memo
  #     elsif word == text.split.last
  #       memo << [word]
  #       memo
  #     else
  #       memo
  #     end
  #   end
  # end
