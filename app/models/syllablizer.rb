module Syllablizer
  SYLLABLES_PER_LINE = 10

  def syllablize(text)
    ##add condition that looks up synonyms with appropriate number of syllables
    ##when the last word in a line would push the total line syllables
    ##over the set abount --- lots to think about here (total reorganization)
    line = []
    syllables = 0
    text.split.inject([]) do |memo, word|
      syllables += syllable_count(word)
      if syllables <= SYLLABLES_PER_LINE
        line << word
      else
        syllables = syllable_count(word)
        memo << line
        line = [word]
      end
      if word == text.split.last && line != [word]
        memo << line
        memo
      elsif word == text.split.last
        memo << [word]
        memo
      else
        memo
      end
    end
  end

  def syllable_count(word)
    #first check to see if the word has been stored in the db with its
    #syllable count checked to a dictionary
    Odyssey.flesch_kincaid_re("#{word}", true)["syllable_count"]
  end

  def numbers_to_text
  end

  def abbreviations_to_text
  end

  def symbols_to_text
  end
end
