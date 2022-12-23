class String

  def indexes sub_string,start=0
    index = self[start..-1].index(sub_string)
    return [] unless index
    [index+start] + indexes(sub_string,index+start+1)
  end

end

def pick_word(words)
  words.sample
end

def load_dictionary(filename)

  dictionary = File.open(filename, 'r')

  words = []

  dictionary.each_line do |l|
    l = l.chomp

    if l.length <= 12 && l.length >= 5
      words << l
    end
  end

  dictionary.close

  words
end

class Game

  attr_accessor :name

  def initialize(name, filename="words.txt")
    @name = name
    @words = load_dictionary(filename)

    @word_to_guess = pick_word(@words)

    @number_of_guesses = 6

    @display = ""

  end

  def get_user_input
    input = gets.gsub(/[^a-z]/i, '').downcase.chomp.strip
    while input.length != 1
      input = gets.gsub(/[^a-z]/i, '').downcase.chomp.strip
    end
    input
  end

  def add_underscores(times)
    times.times do
      @display += "_"
    end
  end




  def launch_game
    # SETUP DISPLAY
    add_underscores(@word_to_guess.length)

  puts @word_to_guess
  puts @display

  # display number of spaces

  # ask user prompt to guess letter

  guess = get_user_input
  puts guess

    # if guess is right, change blank space to letter

    if @word_to_guess.include?(guess)

      index_array = @word_to_guess.indexes(guess)
      puts "GUESSED CORRECTLY"
      index_array.each { |index| @display[index] = guess}


    else
      puts "WRONG GUESS"
      @number_of_guesses -= 1
    end

    puts @display
      # need to account for spaces with the same letter
    # if guess is wrong, subtract from total number of guess
  # repeat until user is out of guesses or guess the word correctly

  end


end

test_game = Game.new("test")

test_game.launch_game