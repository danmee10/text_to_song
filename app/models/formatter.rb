module Formatter

  def format_text(text_array)
    a_of_a = []
    text_array.collect do |pair|
      pair.each do |line|
        a_of_a << line
      end
    end
  end
end
