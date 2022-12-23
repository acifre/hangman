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
    @length = @word_to_guess.length

    @number_of_guesses = 6

    @display = ""

    @start_game = false

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

  def get_user_guesses
    guess = get_user_input
    if @word_to_guess.include?(guess)
      index_array = @word_to_guess.indexes(guess)
      index_array.each { |index| @display[index] = guess}
      puts "CORRECT GUESS"
    else
      @number_of_guesses -= 1
      puts "WRONG GUESS"
    end

    puts @display

  end

  def welcome_message
    puts "Welcome to Hangman!\n"
    puts "You will have 6 tries to guess the word correctly.\n"
    puts "Ready? Y/N"

    ready = gets.gsub(/[^a-z]/i, '').downcase.chomp.strip

    if ready == "yes"
      @start_game = true
    end

  end


  def launch_game

    # SETUP DISPLAY
    add_underscores(@length)

    # Write out intro to game

    welcome_message

    if @start_game
      puts @display
      while @number_of_guesses > 0
        get_user_guesses
      end
      if @number_of_guesses == 0
        puts "GAME OVER"
      end
      end
    end

  # ask user prompt to guess letter
end

test_game = Game.new("test")

test_game.launch_game