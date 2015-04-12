class Cell
	attr_accessor :value

	def initialize(value = nil)
		@value = value
	end
end

class Board
	attr_accessor :grid

	def initialize(grid = default_grid)
		@grid = grid
	end

	def default_grid
		Array.new(6) { Array.new(7) { Cell.new }}
	end

	def formatted_grid
		@grid.each do |row|
			puts row.map { |cell| cell.value.nil? ? "[ ]" : "[#{cell.value}]" }.join("")
		end
	end

	def get_column(x)
		column = grid.map { |row| row[x] }
		column.reverse
	end

	def set_column(x, value)
		if get_column(x).last.value == nil
			(get_column(x).find { |i| i.value == nil}).value = value
		else
			puts "Column is full. Please try again!"
			false
		end
	end

	def get_row(column)
		get_column(column).reverse.index { |i| i.value != nil }
	end	

	def game_over(column)
		return :winner if winner?(column)
		return :draw if draw?
		false
	end

	def four_adjacent(array)
		count = 1
		array.each_with_index do |e, i|
			if e.value.nil? || i == array.length-1
				next
			elsif e.value == array[i+1].value
				count += 1
			else
				count = 1
			end
			if count >= 4
				return true
			end
		end
		false	
	end

	def vertical(y)
		@grid.transpose[y]
	end

	def horizontal(x)
		@grid[x]
	end

	def diagonal_ne(x,y)
		temp_x = x
		temp_y = y
		temp_array = []
		while temp_x >= 1 && temp_y <= 5
			temp_x -= 1
			temp_y += 1
		end
		while temp_x >= 0 && temp_x <= 5 && temp_y >= 0 && temp_y <= 6
			temp_array << @grid[temp_x][temp_y]
			temp_x+=1
			temp_y-=1
		end
		temp_array
	end

	def diagonal_nw(x,y)
		temp_x = x
		temp_y = y
		temp_array = []
		while temp_x >= 1 && temp_y <= 5
			temp_x -= 1
			temp_y -= 1
		end
		while temp_x >= 0 && temp_x <= 5 && temp_y >= 0 && temp_y <= 6
			temp_array << @grid[temp_x][temp_y]
			temp_x+=1
			temp_y+=1
		end
		temp_array
	end

	def winner?(column)
		x = get_row(column)
		y = column
		if four_adjacent(vertical(y)) || four_adjacent(horizontal(x)) || four_adjacent(diagonal_nw(x,y)) ||	four_adjacent(diagonal_ne(x,y))
			return true
		else
			return false
		end
	end

	def draw?
		grid.flatten.map { |cell| cell.value }.all? { |e| e == "R" || e == "B" }
	end
end

class Game
	attr_reader :players, :board, :current_player, :other_player

	def initialize(players, board = Board.new)
		@players = players
		@board = board
		@current_player, @other_player = players.shuffle
	end

	def switch_players
		@current_player, @other_player = @other_player, @current_player
	end

	def solicit_move
		"#{current_player.name}: Select a column (0-6) to make your move."
	end

	def get_move(human_move = gets.chomp)
		if human_move.to_i < 7 && human_move.to_i >= 0
			human_move.to_i
		else
			puts "Invalid input. Please select a column (0-6) to make your move."
			get_move
		end
	end

	def game_over_message(column)
		return "#{current_player.name} won!" if board.game_over(column) == :winner
		return "The game ended in a tie" if board.game_over(column) == :draw
	end

	def play_again?
		puts "Would you like to play again? (Y/N)"
		answer = gets.chomp.upcase
		if answer == "Y"
			Game.new(players).play
		else
			puts "Goodbye!"
		end
	end

	def play
		puts "#{current_player.name} has randomly been selected as first player"
		while true
			board.formatted_grid
			puts ""
			puts solicit_move
			x = get_move
			if board.set_column(x, current_player.color)
			else
				puts "what?"
				switch_players
			end
			if board.game_over(x)
				puts game_over_message(x)
				board.formatted_grid
				play_again?
				return
			else
				switch_players
			end
		end
	end
end

class Player
	attr_accessor :name, :color

	def initialize(input)
		@color = input.fetch(:color)
		@name = input.fetch(:name)
	end
end



player_one = Player.new({color: "R", name: "Player One"})
player_two = Player.new({color: "B", name: "Player Two"})
players = [player_one, player_two]
Game.new(players).play