class Cell
	attr_accessor :value

	def initialize(value = nil)
		value = nil
	end
end

class Board
	attr_accessor :grid

	def initialize(grid = default_grid)
		@grid = grid
		@moves = 0
		@round = 0
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
		column = grid.map { |row| row[x]}
		column.reverse
	end

	def set_column(x, value)
		if get_column(x).last.value == nil
			(get_column(x).find {|i| i.value == nil}).value = value
		else
			puts "Column is full. Please try again"
		end
	end

	def moves
		@moves += 1
	end

	def round
		@round = (@moves/2.to_f).ceil
	end

	def get_row(column)
		get_column(column).reverse.index { |i| i != nil }
	end

	def game_over(column)
		return :winner if winner?(column)
		return :draw if draw?
		false
	end

	def winner?(column)

	end

	def draw?
		grid.flatten.map { |cell| cell.value }.any? { |element| element.to_s.empty? }
	end
end


# 	def possible_moves(row, column)
# 		moves = [
# 			[column + 1, row], [column - 1, row],
# 			[column + 1, row + 1], [column - 1, row - 1],
# 			[column - 1, row + 1], [column + 1, row - 1],
# 			[column, row + 1], [column, row - 1],
# 		]
# 		moves.select { | move | @grid[move[1]][move[0]].value == @grid[row][column].value }
# end

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
		"#{current_player.name}: Select a row (0-6) to make your move."
	end

	def get_move(human_move = gets.chomp)
		human_move
	end

	def game_over_message
		return "#{current_player.name} won!" if board.game_over == :winner
		return "The game ended in a tie" if board.game_over == :draw
	end

	def play
		puts "#{current_player.name} has randomly been selected as first player"
		while true
			board.formatted_grid
			puts ''
			puts solicit_move
			x = get_move.to_i
			if board.set_column(x, current_player.color)
			else switch_players
			end
			if board.game_over(x)
				game_over_message
				board.formatted_grid
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