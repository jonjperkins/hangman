require "yaml"

class Word

  attr_accessor :random_word
  def initialize
  	@random_word = ''
  end

  def choose_word
  	dictionary = File.readlines("5desk.txt")
  	word = dictionary.sample.chomp
    if word.length > 5 && word.length < 12
  		random_word << word
  	else
  	  choose_word
  	end
  end

  def to_s
  	puts "#{random_word}"
  end

end

class Game

  attr_reader :word, :player
  attr_accessor :grid, :display_board, :check_board, :choices_left, :already_chosen

  def initialize(word, player, check_board = [], choices_left = 6, already_chosen = [], display_board = Array.new(word.length, "_ "))
  	@word = word
  	@player = player
  	@display_board = display_board
  	@check_board = check_board
  	@choices_left = choices_left
  	@already_chosen = already_chosen
  end

  def victory?
  	if display_board == check_board
  		puts "You Won!!"
  		puts "The word was #{word}."
  		exit
  	else
  	end
  end

  def save_game
  	puts "Save game? You must type 'yes' and press enter to save. Press enter to continue without saving."
  	choice = gets.chomp
  	if choice == "yes"
		queue = [@word, @player, @display_board, @check_board, @choices_left, @already_chosen]
		File.open('save.yml', 'w') { |n| n.write(YAML.dump(queue)) }
		exit
	else
		puts "\n" * 50
	end
  end

  def load_game?
	puts "load game?"
	  if gets.chomp == "yes"
		data = YAML.load(File.read('save.yml'))
		@word = data[0]
		@player = data[1]
		@display_board = data[2]
		@check_board = data[3]
		@choices_left = data[4]
		@already_chosen = data[5]
	  else
	  end
  end

  def game_loop
  	get_game_ready
  	load_game?
  	while self.choices_left > 0
  		puts show_board
  		show_chosen
  		player_choice
  		puts ""
  		puts "***************"
  		puts "#{choices_left} choices left."
  		puts "***************"
  		puts ""
  		save_game
  		victory?
  	end
  	puts "Game over."
  	puts "The word was: #{word}."
  	exit
  end

  def get_game_ready
  	word_to_array
  end

  def show_chosen
  	puts ""
   	puts "Letters already tried are below: "
  	puts "#{already_chosen.join(', ')}"
  end

  def word_to_array
  	word.each_char{|x| check_board << x }
  end
  	
  def show_board
  	display_board.join
  end
  
  def player_choice
  	puts ""
  	puts "Choose a letter:"
  	choice = gets.chomp
  	already_chosen << choice
  	if check_board.include? choice
      check_board.each_with_index do |item, index| 
	    if item == choice
		  display_board[index] = choice
	    else
	  	end
	  end
	  puts "Great choice!"
	else
	  puts "\n"
	  puts "That letter isn't in this word."
	  puts "\n"
	  self.choices_left -= 1
    end
  end

end

class Player

  attr_accessor :name

  def initialize(name)
   @name = name
  end

  def to_s
  	"#{name}"
  end

end

test = Game.new(Word.new.choose_word, Player.new("Jon"))


#p test.display_board
#p test.check_board
#p test.word_to_array
#p test.check_board

#p test.check_board
#test.player_choice
#p test.display_board

#p test.choices_left
#puts test.show_board
 
 test.game_loop




 










