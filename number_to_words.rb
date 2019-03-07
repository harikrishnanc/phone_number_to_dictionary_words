class Dictionary
  attr_accessor :all_words
  def initialize(file_path)
    @all_words = File.read("dictionary.txt").split("\n").map(&:downcase) rescue []
  end
end

class NumberToWordMapper

  def initialize
    load_dictionary
    load_mapper
    input = get_input
    if valid_number?(input)
      word_combinations(input) 
    else
      puts 'Sorry number contains 0 or 1.'
    end    
  end

  def get_input
    puts "Please enter a 10 digit number"
    input =  gets.chomp
  end
  

  def valid_number?(input)
     input.length == 10 && input.match(/^[2-9]*$/)
  end

  def load_dictionary
    @dictionary = Dictionary.new("dictionary.txt").all_words    
  end

  def load_mapper
    @mapper = {
      "2" => ['a','b','c'],
      "3" => ['d','e','f'],
      "4" => ['g','h','i'],
      "5" => ['j','k','l'],
      "6" => ['m','n','o'],
      "7" => ['p','q','r','s'],
      "8" => ['t','u','v'],
      "9" => ['w','x','y','z']
    }
  end

  def word_combinations(number)
    number_array = number.chars

    character_combinations = number_array.map{|num| @mapper[num]}

    word_combinations = character_combinations.shift.product(*character_combinations).map(&:join)
  
    match_dictionary_words(word_combinations)
  end

  def match_dictionary_words(word_combinations)
    matched_words = Array.new

    i = 2
    
    for i in 2..7 
      f_word =  word_combinations.map{ |word| word[0..i]}.uniq
      l_word = word_combinations.map { |word| word[i+1..-1]}.uniq

      f_word_match = @dictionary & f_word
      l_word_match = @dictionary & l_word

      combine_word = f_word_match.product(l_word_match)
      matched_words << combine_word unless combine_word.empty?  
    end

    full_matched_words = @dictionary & word_combinations
    matched_words << full_matched_words unless full_matched_words.empty?

    p matched_words.flatten()
  end
end

NumberToWordMapper.new
