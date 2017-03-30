class Hangyman
  attr_accessor :game_word, :game_space, :game_round, :player_attempts, :player_guess

  def initialize
    new_word
    attempts_array
    hide_letters
    menu
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
    @player_attempts = ["a", "e", "i", "o", "u"]
  end

  def attempts_array
    @player_attempts_count = @player_attempts.length
    @player_attempts.push(@player_guess).delete nil
  end

# Gamespace
  def hide_letters
    if @player_guess == nil
       @player_guess = ""
    else
       @game_space = @game_word.gsub(/[^#{@player_attempts}]/, "_") # Block reverse of player_attempts
       @game_space = @game_space.to_s
     end
  end

# Game loop
# Player guess
# --------------------------------------- seperate this method
  def game_round
    hide_letters
# First checks win condition.
    case
    when win_lose? == true
      puts "Your Hangyman is hung... This is bad news."
      puts "The word was \"#{@game_word}.\""
    when win_lose? == false
      puts "You have saved Hangyman! You must feel like such a hero."
      puts "The word is \"#{@game_word}.\""
    when win_lose? == nil
      puts "#{@game_space}"
      puts "Your word has #{@game_word.length} letters."
      puts "Here are your attempts #{@player_attempts}. Make a guess!"
      # GET PLAYER INPUT
      @player_guess = gets.chomp!
  # Cannot repeat letters.
      if @player_guess.match /[0..5]/
        menu_options


      elsif @player_attempts.include?(@player_guess)
        puts "Please enter a letter you haven't yet picked."
        game_round
  # Limit to one character, a-z
      elsif @player_guess.match(/[a-z6..9]/) == nil
        puts "Please enter a character between A and Z. Or enter '0' for the menu."
        game_round
      elsif @player_guess.length != 1
        puts "Please enter just one character."
        game_round
      else
        letter_correct?
      end
    end
  end
# --------------------------------------- seperate this method

# Player guess correct?
# --------------------------------------- seperate this method
  def letter_correct?
    if @game_word.include?(@player_guess)
      puts "\'#{@player_guess}\' is in the hidden word!"
      attempts_array
      game_round
    else
      puts "\'#{@player_guess}\' is not in the hidden word... I'm so sorry for you."
      attempts_array
      game_round
    end
  end
# --------------------------------------- seperate this method

# Win / Lose conditions
# --------------------------------------- seperate this method
  def win_lose?
    if @player_attempts_count > 12
      return true
    elsif @game_word == @game_space
      return false
    else
      return nil
    end
  end
# --------------------------------------- seperate this method


  def menu
    game_menu = puts "Please select an action at any time:\n
                      0: Show Menu\n
                      1: New Game\n
                      2: Save Game\n
                      3: Load Game\n
                      4: Exit Game\n
                      5: Solve\n"
  end

end

class Menu
  def menu_options(player_guess)
    case @player_guess
      when @player_guess == 0
        # Show Menu
        game_menu
      when @player_guess == 1
        # New Game
        Hangyman.new
      when @player_guess == 2
        # Save Game
        save_file = File.open("test.txt", "w+") do |data|
        data.puts @game_word
        data.puts @player_attempts
        data.puts @player_attempts_count
        end
        game_round
      when @player_guess == 3
        # Load Game
        load_file = File.open("test.txt", "r")
      when @player_guess == 4
        # Exit Game
        exit
      when @player_guess == 5
        # Solve
    end
  end
end

Hangyman.new
