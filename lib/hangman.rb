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

    @incorrect_guesses = []

    @player_won = false

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
  def display_info

    puts "\nNumber of guesses left: #{@number_of_guesses}.\n"
    if @incorrect_guesses.length > 1
      puts "Incorrect guesses: #{@incorrect_guesses.join(" ")}\n"
    elsif @incorrect_guesses.length == 1
      puts "Incorrect guesses: #{@incorrect_guesses.first}\n"
    else
      puts "Incorrect guesses: NONE\n"
    end
    puts "\n"
    puts @display
    puts "\n"

  end
  def get_user_guesses
    guess = get_user_input
    if @word_to_guess.include?(guess)
      index_array = @word_to_guess.indexes(guess)
      index_array.each { |index| @display[index] = guess}
      puts "\nCORRECT GUESS\n"
      @player_won = check_won

    else
      @number_of_guesses -= 1
      @incorrect_guesses.push(guess)
      puts "\nWRONG GUESS\n"
    end

    display_info

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

  def check_won
    @word_to_guess == @display
  end

  def launch_game
    puts @word_to_guess
    # SETUP DISPLAY
    add_underscores(@length)

    # Write out intro to game

    welcome_message

    if @start_game
      puts @display
      while @number_of_guesses > 0 && @player_won == false
        get_user_guesses
      end
      if @number_of_guesses == 0 && @player_won == false
        puts "\nGAME OVER\n"
        puts "The word was #{@word_to_guess}.\n"
      elsif @player_won
        puts "\nPLAYER WON\n"
      end
      end
    end


end

test_game = Game.new("test")

test_game.launch_game