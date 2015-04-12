require "spec_helper"

module ConnectFour
	describe Board do
		let(:board) { Board.new }
		context "#initialize" do
			it "creates a Board object" do
				expect(board).to be_instance_of Board
			end

			it "initializes the board with a grid" do
				board_with_grid = Board.new("grid")
				expect{board_with_grid}.to_not raise_error
				expect(board_with_grid.grid).to eq "grid"
			end

			it "initialize with a default grid thats an Array object" do
				expect(board.grid).to be_instance_of Array
			end

			it "creates a default grid with a length of 6" do
				expect(board.grid.length).to eq 6
			end

			it "creates a default grid with each element having a length of 7" do
				board.grid.each do |row|
					expect(row.size).to eq 7
				end
			end
		end

		context "#get_column" do
			it "grabs a specified column from the grid" do
				expect(board.get_column(0).map {|element| element.value}).to eq [nil, nil, nil, nil, nil, nil]
				new_board = Board.new
				new_board.grid[1][0].value = "X"
				expect(new_board.get_column(0).map {|element| element.value}).to eq [nil, "X", nil, nil, nil, nil]
			end
		end

		context "#set_column" do
			it "sets a new color value at the lowest available point of the column" do
				board.set_column(0, "X")
				board.set_column(0, "O")
				expect(board.get_column(0).map {|element| element.value}).to eq [nil, nil, nil, nil, "O", "X"]
			end
		end

		context "#get_row" do
			it "returns the row of the that is changed by set_column" do
				board.set_column(0, "X")
				expect(board.get_row(0)).to eq 5
				board.set_column(0, "O")
				expect(board.get_row(0)).to eq 4 
			end
		end

		context "#horizontal" do
			it "returns the array of the row that is changed" do
				board.set_column(0, "X")
				expect(board.horizontal(5)).to eq ["X", nil, nil, nil, nil, nil, nil]
				board.set_column(1, "O")
				expect(board.horizontal(5)).to eq ["X", "O", nil, nil, nil, nil, nil]
			end
		end

		context "#vertical" do
			it "returns the array of the column that is changed" do
				board.set_column(0, "X")
				expect(board.vertical(0)).to eq [nil, nil, nil, nil, nil, "X"]
				board.set_column(0, "O")
				expect(board.vertical(0)).to eq [nil, nil, nil, nil, "O", "X"]
			end
		end

		context "#diagonal_ne" do
			it "returns the array of the diagonal facing NE that is changed" do
				board.set_column(1, "X")
				board.set_column(1, "O")
				expect(board.diagonal_ne(4, 1)).to eq [nil, nil, nil, nil, "O", nil]
				board.set_column(0, "O")
				expect(board.diagonal_ne(4, 1)).to eq [nil, nil, nil, nil, "O", "O"]
			end
		end			

		context "#diagonal_nw" do
			it "returns the array of the diagonal facing NW that is changed" do
				board.set_column(5, "X")
				board.set_column(5, "O")
				expect(board.diagonal_nw(4, 5)).to eq [nil, nil, nil, nil, "O", nil]
				board.set_column(6, "O")
				expect(board.diagonal_nw(4, 5)).to eq [nil, nil, nil, nil, "O", "O"]
			end
		end

		context "#four_adjacent" do
			it "checks to see if there are four adjacent matching values in a array" do
				array = [1, 2, 3, 3, 3, 3]
				expect(board.four_adjacent(array)).to eq true
			end
		end

		context "#game_over" do
			it "returns :winner if winner? is true" do
				test = "dummy"				
				allow(board).to receive(:winner?) {true}
				expect(board.game_over(test)).to eq :winner
			end

			it "returns :draw if draw? is true" do
				test = "test"				
				allow(board).to receive(:winner?) {false}
				allow(board).to receive(:draw?) {true}
				expect(board.game_over(test)).to eq :draw
			end

			it "returns false if neither winner? and draw? are true" do
				test = "test"
				allow(board).to receive(:winner?) {false}
				allow(board).to receive(:draw?) {false}
				expect(board.game_over(test)).to eq false
			end
		end

		TestCell = Struct.new(:value)
		let(:x_cell) { TestCell.new("X") }
		let(:o_cell) { TestCell.new("O") }
		let(:empty) { TestCell.new(nil) }

		context "#game_over" do
			it "returns :winner when there is a horizonal match" do 
				grid = [
					[empty, empty, empty, empty, empty, empty, empty],
					[empty, empty, empty, empty, empty, empty, empty],
					[empty, empty, empty, empty, empty, empty, empty],
					[empty, empty, empty, empty, empty, empty, empty],
					[o_cell, o_cell, o_cell, empty, empty, empty, empty],
					[x_cell, x_cell, x_cell, x_cell, empty, empty, empty]
				]
				board_with_grid = Board.new(grid)
				expect(board_with_grid.game_over(3)).to eq :winner
			end

			it "returns :winner when there is a vertical match" do 
				grid = [
					[empty, empty, empty, empty, empty, empty, empty],
					[empty, empty, empty, empty, empty, empty, empty],
					[x_cell, empty, empty, empty, empty, empty, empty],
					[x_cell, empty, empty, empty, empty, empty, empty],
					[x_cell, o_cell, o_cell, empty, empty, empty, empty],
					[x_cell, o_cell, o_cell, x_cell, empty, empty, empty]
				]
				board_with_grid = Board.new(grid)
				expect(board_with_grid.game_over(0)).to eq :winner
			end		

			it "returns :winner when there is a diagonal_nw match" do 
				grid = [
					[empty, empty, empty, empty, empty, empty, empty],
					[empty, empty, empty, empty, empty, empty, empty],
					[x_cell, empty, empty, empty, empty, empty, empty],
					[o_cell, x_cell, empty, empty, empty, empty, empty],
					[o_cell, o_cell, x_cell, empty, empty, empty, empty],
					[x_cell, o_cell, o_cell, x_cell, empty, empty, empty]
				]
				board_with_grid = Board.new(grid)
				expect(board_with_grid.game_over(0)).to eq :winner
			end

			it "returns :winner when there is a diagonal_ne match" do 
				grid = [
					[empty, empty, empty, empty, empty, empty, empty],
					[empty, empty, empty, empty, empty, empty, empty],
					[x_cell, empty, empty, o_cell, empty, empty, empty],
					[x_cell, empty, o_cell, x_cell, empty, empty, empty],
					[x_cell, o_cell, o_cell, o_cell, empty, empty, empty],
					[o_cell, x_cell, x_cell, x_cell, empty, empty, empty]
				]
				board_with_grid = Board.new(grid)
				expect(board_with_grid.game_over(3)).to eq :winner
			end

			it "returns :draw when there are no more spots left" do 
				grid = [
					[x_cell, o_cell, x_cell, o_cell, x_cell, o_cell, x_cell],
					[x_cell, o_cell, x_cell, o_cell, x_cell, o_cell, x_cell],
					[x_cell, o_cell, x_cell, o_cell, x_cell, o_cell, x_cell],
					[o_cell, x_cell, o_cell, x_cell, o_cell, x_cell, o_cell],
					[o_cell, x_cell, o_cell, x_cell, o_cell, x_cell, o_cell],
					[o_cell, x_cell, o_cell, x_cell, o_cell, x_cell, o_cell],
				]
				board_with_grid = Board.new(grid)
				expect(board_with_grid.game_over(0)).to eq :draw
			end															
		end
	end
end