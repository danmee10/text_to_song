module RhymingEngine

  def rhyming_engine(syllable_breakdown)
    if syllable_breakdown.length <= 2
      highlight_existing_rhyming_matches(syllable_breakdown)
    else
      line_pairs = syllable_breakdown.each_slice(2).to_a
      line_pairs.collect do |pair|
        highlight_existing_rhyming_matches(pair)
      end
    end
  end

  def highlight_existing_rhyming_matches(pair)
    return pair unless pair[1]

    #create an array of rhyming matches for each word in array 1
    first_lines_matches = rhyming_matches_array(pair[0])
    #check rhyming matches for each word in array 1 against words in array 2
    highlited_second_line = pair[1].collect do |word|
      if rhyming_matches_include?(first_lines_matches, word)
        word.upcase
      else
        word
      end
    end
    [pair[0], highlited_second_line]
  end

  def rhyming_matches_include?(array_of_rhyming_match_arrays, word)
    all_matches = []
    array_of_rhyming_match_arrays.each do |rhyming_match_array|
      rhyming_match_array.each { |word_object| all_matches << word_object}
    end
    all_matches.any? { |word_object| word_object.spelling == word }
  end

  def rhyming_matches_array(array_of_words_to_be_matched)
    #takes in a line
    #returns that word's rhyming matches if there are any
    #finds its rhyming matches and returns those if there aren't
    line_of_word_objects = array_of_word_objects(array_of_words_to_be_matched)
    line_of_word_objects.collect do |word|
      if word.rhymes != []
        word.rhymes
      else


        #find or create new words with all the rhyming matches, and add relationships
        rhyme_brain_word_objects = rhyme_brain(word.spelling.match(/[a-zA-Z]+/)).collect do |rhyming_match|
          if Word.find_by_spelling(rhyming_match[:word])
            Word.find_by_spelling(rhyming_match[:word])
          else
            Word.create(spelling: rhyming_match[:word],
                  syllable_count: rhyming_match[:syllables],
           checked_to_dictionary: true )
          end
        end
        word.rhymes = rhyme_brain_word_objects
        word.rhymes
      end
    end
  end

  def array_of_word_objects(array_of_strings)
    array_of_strings.collect { |string| Word.find_by_spelling(string) }
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
    real_words = response.select { |rhyme| rhyme["flags"].to_s.match(/b/) != nil }
    real_words.collect { |rhyme| {word: rhyme["word"], syllables: rhyme["syllables"].to_i} }
  end

  def rhyming_pair?(word, base_word)
    false
    #check to see if word already exists in base_word's rhyming matches
  end
end

###---------service methods---------###
  # def rhyme_last_words(pair)
  #   if pair.length == 1
  #     pair[0]
  #   else
  #     line_one = pair[0]
  #     line_two = pair[1]
  #     line_two[-1] = rhyme(line_two[-1], line_one[-1])
  #     [line_one, line_two]
  #   end
  # end

  # def rhyme(word, base_word)
  #   if rhyming_pair?(word, base_word)
  #     word
  #   else
  #     #look up word in the thesaurus
  #     if word.split(//).all? { |l| l.match(/[a-zA-Z]/) }
  #       synonyms = thesaurus(word)
  #     else
  #       synonyms = word
  #     end
  #     #look up base_word in rhyming dictionary
  #     if base_word.split(//).all? { |l| l.match(/[a-zA-Z]/) }
  #       rhymes = rhyme_brain(base_word)
  #     else
  #       rhymes = word
  #     end
  #     #return the first match between the two results with closest number of syllables
  #     if synonyms == [] && rhymes == [] || synonyms.class == String && rhymes.class == String
  #       rhymes.first
  #     else
  #       look_for_matches(synonyms, rhymes)
  #     end
  #   end
  # end
