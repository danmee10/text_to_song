require 'spec_helper'

describe Syllablizer do

  class TestSong
    include Syllablizer
  end
  let(:text) { "A pidgin, or pidgin language, is a simplified language that develops as a means of communication" }
  let(:song) { TestSong.new }

  describe "#syllablize" do
    context "given a string with more syllables than the SYLLABLES_PER_LINE constant" do
      it "breaks the string into an array of arrays of strings" do
        stub_const("Syllablizer::SYLLABLES_PER_LINE", 5)
        expect(song.syllablize(text).class).to eq Array
        expect(song.syllablize(text)[0].class).to eq Array
        expect(song.syllablize(text)[0][0].class).to eq String
      end

      it "the resulting strings have no more than the number of syllables than the SYLLABLES_PER_LINE constant" do
        stub_const("Syllablizer::SYLLABLES_PER_LINE", 5)
        first_line = song.syllablize(text)[0].join(" ")
        song.syllablize(text).each do |line|
          expect(song.syllable_count(line.join(" "))).to be < 6
        end
      end
    end

    context "given a string with less syllables than the SYLLABLES_PER_LINE constant" do
      it "returns the string inside of a nested array" do
        expect(song.syllablize("too short")).to eq [["too short"]]
      end
    end
  end
end
