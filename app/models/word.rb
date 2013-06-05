class Word < ActiveRecord::Base
  attr_accessible :spelling, :syllable_count, :checked_to_dictionary, :part_of_speech


  validates :spelling, presence: :true, :unless => :space?
  validates_uniqueness_of :spelling, :scope => :part_of_speech
  validates_uniqueness_of :part_of_speech, :scope => :spelling

  has_many :synonym_relationships
  has_many :synonyms, :through => :synonym_relationships
  has_many :rhyming_relationships
  has_many :rhymes, :through => :rhyming_relationships

  has_many :linewords
  has_many :lines, :through => :linewords


  def to_s
    spelling
  end

  def self.text_to_word_objects(text)
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
        word_with_break = [objectify(word), objectify_character(char)]
        word = ''
        word_with_break
      end
    end
    objectified_text_array.flatten.delete_if do |x|
      x == '' || x.spelling == "\r" || x.spelling == "\n" || x.spelling == ""
    end
  end

  def self.objectify(word)
    existing_word_object = find_by_spelling(word)
    if existing_word_object
      existing_word_object
    else
      create(spelling: word, syllable_count: syllable_count(word))
    end
  end

  def self.objectify_character(char)
    existing_character = find_by_spelling(char)
    if existing_character
      existing_character
    else
      create(spelling: char, syllable_count: 0, part_of_speech: "symbol")
    end
  end

  def space?
    spelling == " "
  end

  def self.syllable_count(word)
    Odyssey.flesch_kincaid_re("#{word}", true)["syllable_count"]
  end

  def rhyming_matches
    if rhymes == []
      rhyme_brain.each do |word|
        rhymes << word
      end
      rhymes
    else
      rhymes
    end
  end

  def thesaurus_checker
    if synonyms == []
      thesaurus.each do |word|
        synonyms << word
      end
      synonyms
    else
      synonyms
    end
  end

  def rhyme_brain
    full_response = HTTParty.get("http://rhymebrain.com/talk?function=getRhymes&word=#{spelling}")
    rhymes = rhyme_brain_parser(full_response).collect do |response|
      if Word.find_by_spelling(response[:word])
        Word.find_by_spelling(response[:word]).update_attributes(syllable_count: response[:syllables], checked_to_dictionary: true)
        Word.find_by_spelling(response[:word])
      else
        Word.create(spelling: response[:word], syllable_count: response[:syllables], checked_to_dictionary: true)
      end
    end
  end

  def rhyme_brain_parser(response)
    real_words = response.select { |rhyme| rhyme["flags"].to_s.match(/b/) != nil }
    real_words.collect { |rhyme| {word: rhyme["word"], syllables: rhyme["syllables"].to_i} }
  end

  def thesaurus
    key = ENV['THESAURUS_KEY']
    full_response = HTTParty.get("http://words.bighugelabs.com/api/2/#{key}/#{spelling}/json")
    unless full_response == ''
      word_objects_array = thesaurus_parser(full_response).collect do |word|
        if Word.find_by_spelling(word)
          Word.find_by_spelling(word)
        else
          Word.create(spelling: word)
        end
      end
    end
    word_objects_array
  end

  def thesaurus_parser(response)
    a = []
    if response['noun']
      a << response['noun']['syn']
    end
    if response['verb']
      a << response['verb']['syn']
    end
    if response['adverb']
      a << response['adverb']['syn']
    end
    if response['adjective']
      a << response['adjective']['syn']
    end
    a.flatten
  end
end
