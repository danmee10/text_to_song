module Formatter

  def format_text(text_array)
    a_of_a = []
    text_array.collect do |pair|
      pair.each do |line|
        a_of_a << line
      end
    end
  end
##separates variations in capitalization into separate objects
  # def self.objectify_word(word)
  #   existing_word_object = Word.find_by_spelling(word)
  #   if existing_word_object
  #     existing_word_object
  #   elsif word != word.downcase
  #     if Word.find_by_spelling(word.downcase)
  #       AltSpelling.find_or_create(word, Word.find_by_spelling(word.downcase).id)
  #     else
  #       new_word = Word.create(spelling: word.downcase, syllable_count: Word.syllable_count(word))
  #       AltSpelling.new(alt_spelling: word, word_id: new_word.id)
  #     end
  #   else
  #     Word.create(spelling: word, syllable_count: Word.syllable_count(word))
  #   end
  # end

  def lowercase_letters_only(word)
    letters = word.char.collect do |char|
      char.match(/[a-zA-Z]/)
    end
    letters.join.downcase
  end

  def normalize_text(text)
    text.split.select { |word| word.match(/[a-zA-Z]+/)}
  end

  def numbers_to_text
  end

  def abbreviations_to_text
  end

  def symbols_to_text
  end
end
