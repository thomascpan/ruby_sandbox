require 'yaml'

class Hangman
	def menu
		puts introduction
		user_input = gets.chomp

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
				return menu
		end
	end

	def new_game_setup
		@incorrect_guesses_count = incorrect_guesses_count
		@secret_word = secret_word
		@guess_line = guess_line
		@misses = []
	end

	def game_control
		display
		while true
			@guess = guess
			check_guess(@guess)
			display
			if game_over
				puts game_over_message
				return menu
			end
		end
	end

	def new_game
		new_game_setup
		game_control
	end

	# Randomly selects a word between 5 to 12 letters. 
	def secret_word
		selected_text = []
		text = File.open('5desk.txt').each do |line|
			if line.strip.size >=5 && line.strip.size <=12
				selected_text << line.strip
			end
		end
		selected_text[rand(selected_text.size)].downcase.chomp
	end

	# Introduction text. 
	def introduction
		"Welcome to Hangman!\n\n Do you want to (l)oad a game, (s)tart a new game, (d)elete a game, or (q)uit.\n"
	end

	# Gets guess from user. 
	def guess
		puts "Pick a letter. (enter 'save' at anytime to save the game)"
		input = gets.chomp.downcase
		return input if input.size == 1
		if input == 'save'
			save_game
			return menu
		end
		puts "That doesn't make sense. Try again."
		return guess
	end

	def incorrect_guesses_count
		count = 0
	end

	def guess_line
		guess_line = []
		@secret_word.size.times do 
			guess_line << "_"
		end
		guess_line
	end

	# Checks if guess is correct. 
	def check_guess(guess)
		if @secret_word.include?(guess)

			temp_secret_word = @secret_word.clone
			temp_secret_word = temp_secret_word.split('')

			temp_secret_word.each_with_index {|letter, index| @guess_line[index] = guess if temp_secret_word[index] == guess}
		else
			@misses << guess
			@incorrect_guesses_count += 1
		end
	end

	# Display guess_line, incorrect_guesses_count, and misses. 
	def display
		puts "#{@guess_line.join(' ')} | #{@incorrect_guesses_count} | #{@misses.join(' ')}"
	end

	def game_over
		return :winner if winner?
		return :loser if loser?
		false
	end

	def winner?
		return :winner if @secret_word == @guess_line.join('')
		false
	end

	def loser?
		return :loser if @incorrect_guesses_count == 8
		false
	end

	def game_over_message
		return "You win!" if game_over == :winner
		return "You lose! Secret Word was #{@secret_word}" if game_over == :loser
	end

	def save_game
		yaml = YAML::dump(self)
		puts 'Enter save file name (no spaces please).'
		save = gets.chomp
		save_file = File.new("saves/#{save}.yaml", "w")
		save_file.write(yaml)
		save_file.close
	end

	def load_game
		saves = check_save_files
		puts saves

		puts "Enter the file name you wish to load."
		load_file = gets.strip
		yaml = "saves/#{load_file}"
		if saves.include?(yaml)
			load = YAML::load_file(yaml)
			return load.game_control
		end

		puts "Invalid file name.\n\n"
		return menu
	end

	def check_save_files
		saves = Dir.glob('saves/*')
		if saves.empty?
			puts 'No save files.'
			return menu
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

		return menu
	end

end

game = Hangman.new.menu