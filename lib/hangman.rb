# Load in full dictionary
full_dictionary = File.read('5desk.txt')
dictionary = full_dictionary.scan(/\w+/) #convert to array
dictionary.delete_if { |word| word =~ (/[A-Z]\w+/) } # eliminate words beginning with a capital letter
dictionary.delete_if { |word| word.length <= (4) }
dictionary.delete_if { |word| word.length >= (13) }

# Select random word
game_word = dictionary.sample # define method?

# Gamespace
word_length = game_word.length
word_length.times do |letter| print "_" end

# Player guess
player_guess = gets
puts player_guess

word_length.include?(player_guess)
