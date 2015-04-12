module ConnectFour
	class Board
		attr_reader :grid

		def initialize(grid = default_grid)
			@grid = grid
		end

		def default_grid
			Array.new(6) { Array.new(7) { Cell.new }}
		end

		def formatted_grid
			grid.each do |row|
				puts row.map { |cell| cell.value.nil? ? "[ ]" : "[#{cell.value}]" }.join("")
			end
		end

		def get_column(column)
			grid.transpose[column]
		end

		def set_column(column, value)
			if get_column(column).first.value == nil
				reverse_column = get_column(column).reverse
				reverse_column[reverse_column.index { |x| x.value == nil}].value = value
			else
				puts "Column is full. Please pick another column!"
				false
			end
		end

		def get_row(column)
			get_column(column).index {|x| x.value != nil}
		end

		def horizontal(row)
			grid[row].map { |e| e.value }
		end

		def vertical(column)
			grid.transpose[column].map { |e| e.value }
		end

		def diagonal_ne(row, column)
			x = row
			y = column
			temp_array = []
			while x > 0 && y < 6
				x -= 1
				y += 1
			end
			while x >= 0 && x <= 5 && y >= 0 && y <= 6
				temp_array << grid[x][y].value
				x += 1
				y -= 1
			end
			temp_array
		end

		def diagonal_nw(row, column)
			x = row
			y = column
			temp_array = []
			while x > 0 && y > 0
				x -= 1
				y -= 1
			end
			while x >= 0 && x <= 5 && y >= 0 && y <= 6
				temp_array << grid[x][y].value
				x += 1
				y += 1
			end
			temp_array
		end

		def four_adjacent(array)
			count = 1
			array.each_with_index do |e, i|
				if e.nil? || i == array.length-1
					next
				elsif e == array[i+1]
					count += 1
				else
					count = 1
				end
				return true if count == 4
			end
			return false
		end

		def game_over(column)
			return :winner if winner?(column)
			return :draw if draw?
			false
		end

		private

		def winner?(column)
			x = get_row(column)
			y = column
			if four_adjacent(vertical(y)) || four_adjacent(horizontal(x)) || four_adjacent(diagonal_ne(x, y)) || four_adjacent(diagonal_nw(x,y))
				return true
			else
				return false
			end
		end

		def draw?
			grid.flatten.map { |cell| cell.value }.all? { |e| e == "X" || e == "O"}
		end
	end
end
