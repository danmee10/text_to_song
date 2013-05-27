module Syllablizer
  SYLLABLES_PER_LINE = 5

  def syllablize(text)
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
      if word == text.split.last
        memo << [word]
        memo
      else
        memo
      end
    end
  end

  def syllable_count(word)
    Odyssey.flesch_kincaid_re("#{word}", true)["syllable_count"]
  end
end
