require 'yaml'

class Hangman
	def initialize
		load_words
	end

	def load_words
		@words = File.open('5desk.txt','r').readlines.collect { |word| word.strip if (word.strip.size >= 5 && word.strip.size <= 12) }
	end

	def new_game_setup
		@win_word = @words[rand(@words.size - 2)].split('')
		@game_word = ("_" * (@win_word.size)).split('')
		@letters_guessed = []
		@misses = []
		@max_misses = 6
	end

	def user_turn
		misses = @misses.empty? ? 'None' : @misses.sort.join(', ')
		puts "\nWord: #{@game_word.join(" ")}.\nMisses: #{misses}. Your Guess? (enter 'save' at anytime to save your game)."
		guess = gets.downcase.strip
	  action = update_based_on_turn(guess)
	end

	def update_based_on_turn(guess)

		if guess == 'save'
			save_game
			return 'save'
		elsif @letters_guessed.include?(guess)
				puts "You've already guessed this.\n"
				return 'repeat'
		elsif guess[/\w/] && guess.size == 1
			@letters_guessed << guess
			if @win_word.include?(guess)
				@win_word.each_with_index { | c, i | @game_word[i] = guess if @win_word[i] == guess }
				return win? ? 'win' : 'correct'
			else
				@misses << guess
				return lose? ? 'lose' : 'miss'
			end
		else
			puts "Invalid character.\n"
			return 'repeat'
		end

	end

	def lose?
		return @misses.size == @max_misses
	end

	def win?
		return @game_word == @win_word
	end

	def game_control
		result = user_turn
		case result
			when 'save'
				puts "Thanks for saving.\n"
				return menu_control
			when 'win'
				puts "Nice! You win. The word was #{@game_word.join("")}, and it took your #{@letters_guessed.size} turns.\nThanks for playing!\n\n"
				return menu_control
			when 'lose'
				puts "Ah man! You lose. The word was #{@win_word.join("")}, and you lost in #{@letters_guessed.size} turns.\nThanks for playing!\n\n"
				return menu_control
			else
				puts "Wrong!\n" if result == 'miss'
				return game_control
		end
	end

	def menu_control
		puts "Welcome to Hangman. Are you up for the challenge?\n\nDo you want to (l)oad a saved game, (s)tart a new game, (d)elete a saved game, or (q)uit? "
		user_input = gets.strip

		case user_input.downcase
			when 'l'
				load_game
			when 's'
				new_game
			when 'q'
				puts "Thanks for playing\n"
				return
			when 'd'
				delete_game
			else
				puts "Invalid entry!\n\n"
				return menu_control
		end
	end

	def check_save_files
		saves = Dir.glob('saves/*')
		if saves.empty?
			puts 'No save files.'
			return menu_control
		end
		puts "Current saves:"
		puts saves.join(', ')
		puts "\n"
		saves
	end

	def delete_game
		saves = check_save_files
		puts 'Enter the file name you wish to delete.'
		delete_file = gets.strip
		file = "saves/#{delete_file}"
		if saves.include?(file)
			File.delete(file)
			puts "File deleted successfully!"
		else
			puts "Invalid file name.\n\n"
		end

		return menu_control
	end

	def save_game
		yaml = YAML::dump(self)
		puts 'Enter save file name (no spaces please).'
		save = gets.strip.split(" ")[0]
		save_file = File.new("saves/#{save}.yaml", 'w')
		save_file.write(yaml)
	end

	def load_game
		saves = check_save_files
	
		puts 'Enter the file name you wish to load.'
		load_file = gets.strip
		yaml = "saves/#{load_file}"
		if saves.include?(yaml)
			load = YAML::load_file(yaml)
			return load.game_control
		end
		
		puts "Invalid file name.\n\n"
		return menu_control
	end

	def new_game
		new_game_setup
		game_control
	end

end

game = Hangman.new
game.menu_control