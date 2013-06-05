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
    words = Word.text_to_word_objects(text)
    line = Line.create
    lines_array = []
    words.collect do |word|


      if (line.syllables + word.syllable_count) <= @syllables_per_line
        if word.class == Word
          line.words << word
        else
          line.alt_spellings << word
        end
      else
        lines_array << line
        line = Line.create
        if word.class == Word
          line.words = [word]
        else
          line.alt_spellings = [word]
        end
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
end
    # <div class="span6 slide-out-div" style="line-height: 1; position: fixed; height: 290px; top: 200px; left: -300px;">
    #   <a class="handle" href="#" style="width: 36px; height: 130px; display: block; text-indent: -99999px; outline: none; position: absolute; top: 0px; right: -36px; background-position: initial initial; background-repeat: no-repeat no-repeat;">Original Text</a>
    #   <p><%= @song.original_text %></p>
    # </div>
    # <div class="span6 slide-out-div-two">
    #   <a class="handle-two" href="#">Original Text</a>
    #   <%= render "options_form" %>
    # </div>





  # def text_to_lines(text)
  #   words = Word.text_to_word_objects(text)
  #   line = Line.create
  #   lines_array = []
  #   line_position_index = 1
  #   words.each do |word|
  #     fail
  #     if (line.syllables + word.syllable_count) <= @syllables_per_line
  #       Lineword.create(line_id: line.id,word_id: word.id, word_index: line_position_index)
  #       line_position_index += 1
  #     else
  #       lines_array << line
  #       line = Line.create
  #       line_position_index = 1
  #       Lineword.create(line_id: line.id,word_id: word.id, word_index: line_position_index)
  #     end

  #     if word = words.last
  #       lines_array << line
  #     end
  #   end

  #   lines_array.uniq
  # end
