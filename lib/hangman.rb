
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

words = load_dictionary("words.txt")

p pick_word(words)