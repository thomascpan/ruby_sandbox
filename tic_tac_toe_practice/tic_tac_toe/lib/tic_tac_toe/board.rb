module TicTacToe
	class Board
		attr_reader :grid
		def initialize(input = {})
			@grid = input.fetch(:grid, default_grid)
		end

		def get_cell(x, y)
			grid[y][x]
		end

		def set_cell(x, y, value)
			get_cell(x, y).value = value
		end

		def game_over
			if winner? == true
				return :winner
			elsif draw? == true
				return :draw
			else
				return false
			end
		end

		def formatted_grid
			grid.each do |row|
				puts row.map { |cell| cell.value.empty? ? "_" : cell.value }.join(" ")
			end
		end

		private

		def default_grid
			Array.new(3) { Array.new(3) { Cell.new } }
		end

		def winning_positions
			rows + columns + diagonals
		end

		def rows
			grid
		end

		def columns
			grid.transpose
		end

		def diagonals
			[
				[get_cell(0, 0), get_cell(1, 1), get_cell(2, 2)],
				[get_cell(0, 2), get_cell(1, 1), get_cell(2, 0)]
			]
		end

		def draw?
			grid.flatten.none? {|cell| cell.value == "" }
		end

		def winner?
			winning_positions.each do |winning_position|
				next if winning_position_values(winning_position).all? {|cell| cell == "" }
				return true if winning_position_values(winning_position).all? {|cell| cell == winning_position[0].value}
			end
			false
		end

		def winning_position_values(winning_position)
			winning_position.map {|cell| cell.value}
		end
	end
end