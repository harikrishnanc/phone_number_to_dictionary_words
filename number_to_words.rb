class NumberToWordMapper

  def initialize
    input = get_input
    puts valid_number?(input)
  end

  def get_input
    puts "Please enter a 10 digit number"
    input =  gets.chomp
  end
  

  def valid_number?(input)
     (input.length == 10 && input.match(/^[2-9]*$/))
  end

end

NumberToWordMapper.new
