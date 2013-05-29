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

  def rhyme(word, base_word)
    if rhyming_pair?(word, base_word)
      word
    else
      #look up word in the thesaurus
      if word.split(//).all? { |l| l.match(/[a-z]/) }
        synonyms = thesaurus(word)
      else
        synonyms = word
      end
      #look up base_word in rhyming dictionary
      if base_word.split(//).all? { |l| l.match(/[a-z]/) }
        rhymes = rhyme_brain(base_word)
      else
        rhymes = word
      end
      #return the first match between the two results with closest number of syllables
      if synonyms == [] || rhymes == [] || synonyms.class == String || rhymes.class == String
        word
      else
        matches = synonyms.select { |word| rhymes.include?(word) }
        matches.first
      end
    end
  end

  def thesaurus(word)
    key = ENV['THESAURUS_KEY']
    full_response = HTTParty.get("http://words.bighugelabs.com/api/2/#{key}/#{word}/json")
    unless full_response.body == ''
      thesaurus_parser(full_response)
    else
      word
    end
  end

  def thesaurus_parser(response)
    if response['noun'] && response['verb']
      response['noun']['syn'] + response['verb']['syn']
    elsif response['noun']
      response['noun']['syn']
    elsif response['verb']
      response['verb']['syn']
    else
      []
    end
  end

  def rhyme_brain(word)
    full_response = HTTParty.get("http://rhymebrain.com/talk?function=getRhymes&word=#{word}")
    rhyme_brain_parser(full_response)
  end

  def rhyme_brain_parser(response)
    response.collect { |rhyme| rhyme["word"] }
  end

  def rhyming_pair?(word, base_word)
    false
    #check to see if word already exists in base_word's rhyming matches
  end
end
