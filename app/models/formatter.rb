module Formatter

  def format_text(text_array)
    a_of_a = []
    text_array.collect do |pair|
      pair.each do |line|
        a_of_a << line
      end
    end
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
