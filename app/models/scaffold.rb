class Scaffold
  include Formatter
  attr_reader :lines, :stanzas

  def initialize(text, song_id, syllables_per_line=10, lines_per_stanza=4)
    @song_id = song_id
    @syllables_per_line = syllables_per_line
    @lines_per_stanza = lines_per_stanza
    @lines = text_to_lines(text)
    @stanzas = lines_to_stanzas(@lines)
  end

  def text_to_lines(text)
    words = text_to_word_objects(text)
    line = Line.create
    lines_array = []
    words.collect do |word|


      if (line.syllables + word.syllable_count) <= @syllables_per_line
        if word.class == Word
          line.words << word
        else
          line.alt_spellings << word
        end
      else
        lines_array << line
        line = Line.create
        if word.class == Word
          line.words = [word]
        else
          line.alt_spellings = [word]
        end
      end

      if word = words.last
        lines_array << line
      end


    end
    lines_array.uniq
  end

  def lines_to_stanzas(lines)
    stanzas_array = []
    lines.each_slice(@lines_per_stanza).collect do |four_line_group|
      stanza = Stanza.create(song_id: @song_id)
      four_line_group.each do |line|
        stanza.lines << line
      end
      stanzas_array << stanza
    end
    stanzas_array
  end

  def text_to_word_objects(text)
    ##returns an array of word and alt_spelling objects
    ##as well as the original punctuation interspersed
    letter = ''
    word = ''
    objectified_text_array = text.split(//).collect do |character|
      char = character
      if char.match(/[a-zA-Z]/)
        word += char
        ""
      else
        word_with_break = [Formatter.objectify_word(word), Formatter.objectify_character(char)]
        word = ''
        word_with_break
      end
    end
    objectified_text_array.delete_if { |x| x == "" }.flatten
  end
end


  # def text_to_word_objects(text)
  #   text.split.collect do |word|
  #     normalized_word = lowercase_letters_only(word)
  #     existing_word = Word.find_by_spelling(normalized_word)
  #     if existing_word
  #       existing_word
  #     else
  #       Word.create(spelling: normalized_word, syllable_count: Odyssey.flesch_kincaid_re("#{normalized_word}", true)["syllable_count"])
  #     end
  #   end
  # end
