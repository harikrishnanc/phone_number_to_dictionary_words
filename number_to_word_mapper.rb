class Dictionary
  attr_accessor :all_words
  def initialize(file_path)
    @all_words = File.read(file_path).split("\n").map(&:downcase) rescue []
  end
end

class NumberToWordMapper

  def initialize
    #initializing Dictionary
    load_dictionary
    #initializing Mapper
    load_mapper
    unless ENV["ENV"] == "test"
      input = get_input 
    
      if valid_number?(input)
        start_time
        word_combinations(input) 
        end_time
        puts "Time taken to excute #{(@end_time.to_f - @start_time.to_f)} sec"
      else
        puts 'Sorry number contains 0 or 1.'
      end 
    end
    
  end

  def get_input
    puts "Please enter a 10 digit number"
    input =  gets.chomp
  end

  def start_time
    @start_time = Time.now()
  end

  def end_time
    @end_time = Time.now()
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
      
    #converting number to chars array
    number_array = number.chars

    #Mapping individual number with mapper inputs
    character_combinations = number_array.map{|num| @mapper[num]}
    
    # Making all possible combination of words
    word_combinations = character_combinations.shift.product(*character_combinations).map(&:join)
  
    match_dictionary_words(word_combinations)
    

  end

  #matching the words with dictionary
  def match_dictionary_words(word_combinations)
    matched_words = Array.new

    #Minimum word length is 3 
    i = 2
    
    #Looping to get all combination of words 
    for i in 2..7 
      f_word =  word_combinations.map{ |word| word[0..i]}.uniq
      l_word = word_combinations.map { |word| word[i+1..-1]}.uniq

      #matching with Dictionary
      f_word_match = @dictionary & f_word
      l_word_match = @dictionary & l_word

      # concating the above matched words
      combine_word = f_word_match.product(l_word_match)
      # Adding the word to array(non-blank)
      matched_words << combine_word unless combine_word.empty?  
    end

    #matching full word with Dictionary
    full_matched_words = @dictionary & word_combinations
    matched_words << full_matched_words unless full_matched_words.empty?

    # Final array in single line - flatten
    p matched_words.flatten(1)
  end
end

NumberToWordMapper.new
