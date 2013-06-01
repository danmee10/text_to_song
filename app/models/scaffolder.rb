module Scaffolder
  include Formatter
  SYLLABLES_PER_LINE = 10

  def lines_and_stanzas(text)
    ##add condition that looks up synonyms with appropriate number of syllables
    ##when the last word in a line would push the total line syllables
    ##over the set abount --- lots to think about here (total reorganization)

    words = text_to_word_objects(text)
    line = Line.create
    lines_array = words.collect do |word|
      #put 10syls of words in a line
      while line.syllables < SYLLABLES_PER_LINE
        line.words << word
      end
      line = Line.create
    end
    #put 4 lines in a stanza
    stanzas_array = lines_array.each_slice(4).collect do |four_line_group|
      Stanza.create.lines << four_line_group
    end
    #return array of stanzas
    return stanzas_array
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
