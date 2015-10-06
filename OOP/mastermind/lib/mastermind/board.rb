module Mastermind
	class Board

		attr_reader :grid, :solution

		# Initialize with a default_grid with blank values
		def initialize
			@grid = default_grid
			@solution = random_solution
		end

		# Get the guess array.
		def get_guess(round, guess_cat = 0)
			grid[round][guess_cat]
		end

		# Set the value of each cell in the guess array. 
		def set_guess(round, guess, guess_cat = 0)
			get_guess(round).each_with_index do |cell, index|
				cell.value = guess[index]
			end
		end

		# Get the hint array
		def get_hint(round, hint_cat = 1)
			grid[round][hint_cat]
		end

		# Set the value of each cell in the hint array. 
		def set_hint(round, the_hint, hint_cat = 1)
			get_hint(round).each_with_index do |cell, index|
				cell.value = the_hint[index]
			end
		end

		# Generates hint array based off guess.
		def hint(guess)
			@hint_array = []
			@temp_solution_array = []
			@temp_guess_array = guess.split('')
			test_same_color_and_position(solution)
			test_same_color_different_position
			return @hint_array
		end

		# Creates a blank game board display.
		def formatted_grid
			grid.each do |row|
				new_row = row.flatten
				puts new_row.map { |cell| cell.value.nil? ? "_" : cell.value}.join(" ")
			end
		end

		def game_over?(round, hint)
			return :winner if winner?(hint)
			return :loser if loser?(round)
			false
		end		

		def set_solution
			grid.last.flatten.each_with_index do |cell, i|
				cell.value = solution[i]
			end
		end

			private

			# A default_grid composed of guesses_grid_and_hints_grid and solution_grid.
			def default_grid
				guesses_and_hints_grid + solution_grid
			end

			# Pairs the two arrays into another array. 
			def guesses_and_hints_grid
				i = 0
				combined_array = []
				temp_array = []
				i = 0
				while i < guesses_grid.length
					temp_array = []
					temp_array << guesses_grid[i] << hints_grid[i]
					combined_array << temp_array
					i += 1
				end
				combined_array
			end

			# An array of all the guesses.
			def guesses_grid
				Array.new(12) { Array.new(4) { Cell.new } }
			end

			# An array of all the hints.
			def hints_grid
				Array.new(12) { Array.new(4) { Cell.new } }
			end

			# An array of an array of the solution. 
			def solution_grid
				Array.new(1) { Array.new(1) { Array.new(4) { Cell.new} } }
			end

			# Creates a random solution
			def random_solution
				Array.new(4) {|i| i = random_color}
			end

			# Generates random colors for the solution
			def random_color
				number = rand(6)
				case number 
				when 0
					color = "R"
				when 1
					color = "O"
				when 2
					color = "Y"
				when 3
					color = "G"
				when 4
					color = "I"
				when 5
					color = "V"
				end
			end

			def test_same_color_and_position(solution)
				@temp_solution_array = solution.clone
				i = 0
				while i < 4
					if @temp_guess_array[i] == @temp_solution_array[i]
						@hint_array	<< "B"
						@temp_guess_array[i] = ""
						@temp_solution_array[i] = ""
					end
					i+=1
				end
				return @hint_array
			end

			def test_same_color_different_position
				i = 0
				while i < 4
					if @temp_guess_array[i] == ""
						i+=1
					else
						if @temp_solution_array.find_index(@temp_guess_array[i]) == nil
							i+=1
						else
							@hint_array << "W"
							@temp_solution_array[@temp_solution_array.find_index(@temp_guess_array[i])] = ""
							@temp_guess_array[i] = ""
							i+=1
						end
					end
				end
				return @hint_array
			end

			# Determines if any of the values of the guesses are the same as the values of the solution.
			def winner?(hint)
				hint == ["B", "B", "B", "B"]
			end

			# Determines if none of the guess values are equal to the solution.
			def loser?(round)
				round == 12
			end
	end
end