class Hangyman
  attr_accessor :game_word, :blanks, :game_round

  def initialize
    new_word
    gamespace
    attempts_array
    game_round
  end

  # Load in full dictionary
  def new_word
    full_dictionary = File.read('5desk.txt')
    dictionary = full_dictionary.scan(/\w+/) #convert to array
    dictionary.delete_if { |word| word =~ (/[A-Z]\w+/) } # eliminate words beginning with a capital letter
    dictionary.delete_if { |word| word.length <= (4) }
    dictionary.delete_if { |word| word.length >= (13) }
    @game_word = ""
    @game_word = dictionary.sample
  end

# Gamespace
def gamespace
  @blanks = @game_word.gsub(/./, "_")
end

def attempts_array
  @player_attempts = Array.new
  @player_attempts_count = @player_attempts.length
end

# Game loop
# Player guess
# --------------------------------------- seperate this method
  def game_round
    puts @blanks
    puts "Your word has #{@game_word.length} letters."
    puts "Here are your attempts #{@player_attempts}. Make a guess!"
    @player_guess = gets.chomp!
    # Cannot repeat letters.
    if @player_attempts.include?(@player_guess)
      puts "Please enter a letter you haven't yet picked."
      game_round
    # Limit to one character, a-z
    elsif @player_guess.match(/[[:alpha:]]/) == nil
      puts "Please enter a character between A and Z."
      game_round
    elsif @player_guess.length != 1
      puts "Please enter just one character."
      game_round
    else
      letter_correct?
    end
  end
# --------------------------------------- seperate this method

# Player guess correct?
# --------------------------------------- seperate this method
  def letter_correct?
    if @game_word.include?(@player_guess)
      puts "\'#{@player_guess}\' is in the hidden word!"
      guess_loc =
        each
        @game_word.index(@player_guess) # Player guess string location
      @blanks.insert(guess_loc, @player_guess) # Replace blanks "_" with correct letter
      @player_attempts.push(@player_guess)
      game_round
    else
      puts "\'#{@player_guess}\' is not in the hidden word... I'm so sorry for you."
      @player_attempts.push(@player_guess)
      game_round
    end
  end
# --------------------------------------- seperate this method

# Win / Lose conditions
# --------------------------------------- seperate this method
  def win_lose?
    if @player_attempts_count > 6
      puts "Your Hangyman is hung... This is bad news."
      return true
    elsif @blanks.includes?("_") == false
      puts "You have saved Hangyman! You must feel like such a hero."
      return false
    else nil
    end
  end
end
# --------------------------------------- seperate this method

Hangyman.new
