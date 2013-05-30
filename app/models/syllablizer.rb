module Syllablizer
  SYLLABLES_PER_LINE = 5

  def syllablize(text)
    ##add condition that looks up synonyms with appropriate number of syllables
    ##when the last word in a line would push the total line syllables
    ##over the set abount --- lots to think about here (total reorganization)
    return [] unless text
    words_array = normalize_text(text)

    # return words_array if words_array.length == 1
    line = []
    syllables = 0
    words_array.inject([]) do |memo, word|
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

  def normalize_text(text)
    text.split.select { |word| word.match(/[a-zA-Z]+/)}
  end

  def syllable_count(word)
    existing_word = Word.find_by_spelling(word)
    if existing_word && existing_word.syllable_count
      existing_word.syllable_count
    else
      new_word = Word.create(spelling: word, syllable_count: Odyssey.flesch_kincaid_re("#{word}", true)["syllable_count"])
      new_word.syllable_count
    end
  end

  def numbers_to_text
  end

  def abbreviations_to_text
  end

  def symbols_to_text
  end
end
