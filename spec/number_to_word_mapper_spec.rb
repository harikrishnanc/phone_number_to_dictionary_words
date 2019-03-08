ENV["ENV"] = "test"
require "./number_to_word_mapper"

describe NumberToWordMapper do

    describe "valid_number?" do
        it "should return false for invalid number 0123456789" do
          expect(NumberToWordMapper.new.valid_number?("0123456789")).to be_falsey
        end

        it "should return false for invalid number 1919" do
          expect(NumberToWordMapper.new.valid_number?("1919")).to be_falsey
        end

        it "should return true for valid number 9898798787" do
          expect(NumberToWordMapper.new.valid_number?("9898798787")).to be_truthy
        end
      end

      describe "Number to word mapper: 6686787825" do
        it "Should search all word combination against dictionary and get matching words" do
          expect(NumberToWordMapper.new.word_combinations("6686787825"))
                              .to eq([["noun", "struck"], 
                                      ["onto", "struck"], 
                                      ["motor", "truck"], 
                                      ["motor", "usual"], 
                                      ["nouns", "truck"], 
                                      ["nouns", "usual"], 
                                      "motortruck"])
        end
      end
    
      describe "Number to word mapper: 2282668687" do
        it "Should search all word combination against dictionary and get matching words" do
          expect(NumberToWordMapper.new.word_combinations("2282668687"))
                              .to eq([["act", "amounts"], 
                                      ["act", "contour"], 
                                      ["bat", "amounts"], 
                                      ["bat", "contour"], 
                                      ["cat", "amounts"], 
                                      ["cat", "contour"], 
                                      ["acta", "mounts"], 
                                      "catamounts"])
        end
    end
end