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
    lines.each_slice(@lines_per_stanza).collect do |four_line_group|
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
        word_with_break = [objectify(word), char]
        word = ''
        word_with_break.join
      end
    end
    objectified_text_array
  end

  def objectify(word)
    existing_word_object = Word.find_by_spelling(word)
    if existing_word_object
      existing_word_object
    elsif word != word.downcase
      if Word.find_by_spelling(word.downcase)
        AltSpelling.find_or_create(alt_spelling: word, word_id: Word.find_by_spelling(word.downcase).id)
      else
        new_word = Word.create(spelling: word.downcase)
        AltSpelling.new(alt_spelling: word, word_id: new_word.id)
      end
    else
      Word.create(spelling: word)
    end
  end

  def lowercase_letters_only(word)
    letters = word.char.collect do |char|
      char.match(/[a-zA-Z]/)
    end
    letters.join.downcase
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
