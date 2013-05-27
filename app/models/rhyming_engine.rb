module RhymingEngine
  def rhyming_engine(breakdown)
    #target groups of two
    line_pairs = breakdown.each_slice(2).to_a
    #change the last word of the second to rhyme with the last word of the first
    line_pairs.collect do |pair|
      rhyme_last_words(pair)
    end
  end

  def rhyme_last_words(pair)
    if pair.length == 1
      pair[0]
    else
      line_one = pair[0]
      line_two = pair[1]
      line_two[-1] = rhyme(line_two[-1], line_one[-1])
      [line_one, line_two]
    end
  end

  def rhyme(word, other_word)
    if rhyming_pair?(word, other_word)
      word
    else
      #look up word in the thesaurus
      #return the first match between the rhymes of other_word and thesaurus words for word
    end
  end

  def rhyming_pair?(word, other_word)
    #check to see if word already exists in other_word's rhyming matches
  end
end
