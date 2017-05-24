class Hangyman
  attr_accessor :game_word, :game_space, :game_round, :player_attempts, :player_guess, :menu_selection

  def initialize
    new_word
    attempts_array
    hide_letters
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
    win_lose?
    win_lose_feedback
# GET PLAYER INPUT
      @player_guess = gets.chomp!
      if @player_guess == '0'
        menu
# Cannot repeat letters.
      elsif @player_attempts.include?(@player_guess)
        puts "Please enter a letter you haven't yet picked."
        game_round
# Limit to one character, a-z
      elsif @player_guess =~ /[^a-z0]/
        puts "Please enter a character between A and Z. Or enter '0' for the menu."
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

  def win_lose_feedback
  case
    when win_lose? == true
      puts "Your Hangyman is hung... This is bad news."
      puts "The word was \"#{@game_word}.\""
      menu
    when win_lose? == false
      puts "You have saved Hangyman! You must feel like such a hero."
      puts "The word is \"#{@game_word}.\""
      menu
    when win_lose? == nil
      puts "#{@game_space}"
      puts "Your word has #{@game_word.length} letters."
      puts "Here are your attempts #{@player_attempts}. Make a guess!"
      puts "Please input a letter or \'0\' for the game menu."
    end
  end
# --------------------------------------- seperate this method


  def menu
    @game_menu = puts "Please select an action at any time:\n
                      0: Show Menu\n
                      1: New Game\n
                      2: Save Game\n
                      3: Load Game\n
                      4: Exit Game\n
                      5: Solve\n"
    @menu_selection = gets.chomp!
    menu_options
  end

  def menu_options
    case
      when @menu_selection == '0'
        menu

      when @menu_selection == '1'
        Hangyman.new

      when @menu_selection == '2'
        save_data
        game_round

      when @menu_selection == '3'
        load_data

      when @menu_selection == '4'
        exit

      when @menu_selection == '5'
# Solve
        solve_game
    end
  end

# Selection 2
  def save_data
    save_game = File.new("savegame.txt", "w+")
    save_game.print "#{@player_attempts}" + "\n" # Line 1
    save_game.print "#{@player_attempts_count}" + "\n" # Line 2
    save_game.print "#{@game_word}" # Line 3
    save_game.close
    puts "Game Saved!"
  end

# Selection 3
  def load_data
    load_game = File.open("savegame.txt", "r")
    load_game.lineno = 0
    @player_attemtps = load_game.gets
    load_game.lineno = 1
    @player_attemtps_count = load_game.gets
    load_game.lineno = 2
    @game_word = load_game.gets
    load_game.close
    puts "Game Loaded!"
    game_round
  end

  def solve_game
    puts "Enter your guess:"
    @player_guess = gets.chomp!
    game_round
  end
# Class end
end

hangman = Hangyman.new
