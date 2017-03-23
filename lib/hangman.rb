# Load in full dictionary
full_dictionary = File.read('5desk.txt')
dictionary = full_dictionary.scan(/\w+/) #convert to array
dictionary.delete_if { |word| word =~ (/[A-Z]\w+/) } # eliminate words beginning with a capital letter
dictionary.delete_if { |word| word.length <= (4) }
dictionary.delete_if { |word| word.length >= (13) }

# Select random word
game_word = dictionary.sample # define method?

# Gamespace
gamespace = game_word.gsub(/./, "_")

# Game loop
# Player guess
begin
  player_guess = gets.chomp!

  # Player attempted letters
  player_attempts = Array.new
  player_attempts.push(player_guess)
  player_attempts_count = player_attempts.length

  # Limit to one character a-z
  if player_guess =~ /[a-z]/ || /[A-Z]/
    puts "Please enter a character between A and Z."
  elsif player_guess.length != 1
    puts "Please enter just one character."
  elsif player_attempts.each { |letter| letter == player_guess}
    puts "Please enter a letter you haven't yet picked."
  end

  # Player guess correct?
  if game_word.include?(player_guess)
    puts "#{player_guess} is in the hidden word!"
    guess_loc = game_word.index(player_guess) # Player guess string location
    gamespace.insert(guess_loc, player_guess) # Replace gamespace "_" with correct letter
    puts gamespace
  else
    puts "#{player_guess} is not in the hidden word... I'm so sorry for you."
  end
end while

class WinLoseCondition
  def initialize(player_attempts_count)
    if player_attempts_count > 6
      puts "Your Hangyman is hung... This is bad news."
      return # ?true?
    else gamespace.includes?("_") == false
      puts "You have saved Hangyman! You must feel like such a hero."
    end
  end
end
