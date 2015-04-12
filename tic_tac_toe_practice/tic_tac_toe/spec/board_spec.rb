require "helper_spec"

module TicTacToe
	describe Board do
		context "#initialize" do
			it "intializes with a valid input" do
				input = Board.new({grid: [0, 0]})
				expect {input}.to_not raise_error
			end

			it "initializes with three rows by default" do
				input = Board.new()
				expect(input.grid.size).to eq 3
			end

			it "creates three things in each row by default" do
				input = Board.new()
				input.grid.each do |row|
					expect(row.size).to eq 3
				end
			end
		end

		context "#grid" do
			it "returns the grid" do
				input = Board.new({grid: "grid"})
				expect(input.grid).to eq "grid"
			end
		end

		context "#get_cell" do
			it "returns value of cell at a given coordinate" do
				input = Board.new({grid: [[1, 2, 3], [4, 5, 6], [7, 8, 9]]})
				expect(input.get_cell(0, 0)).to eq 1
			end
		end

		context "#set_cell" do
			it "sets the value of a cell at a given coordinate" do
				Cat = Struct.new(:value)
				input = Board.new({grid: [[Cat.new("hello"), 2, 3], [4, 5, 6], [7, 8, 9]]})
				input.set_cell(0, 0, "goodbye")
				expect(input.get_cell(0, 0).value).to eq "goodbye"
			end
		end

		context "#game_over" do
			it "returns :winner if winner? is true" do
				board = Board.new
				allow(board).to receive(:winner?) {true}
				expect(board.game_over).to eq :winner
			end

			it "returns :draw if draw? is true" do
				board = Board.new
				allow(board).to receive(:winner?) {false}
				allow(board).to receive(:draw?) {true}
				expect(board.game_over).to eq :draw
			end

			it "returns false if both winner? and draw? are false" do
				board = Board.new
				allow(board).to receive(:winner?) {false}
				allow(board).to receive(:draw?) {false}
				expect(board.game_over).to eq false
			end	
		end

		TestCell = Struct.new(:value)
		let(:x_cell) { TestCell.new("X")}
		let(:y_cell) { TestCell.new("Y")}
		let(:empty) { TestCell.new("")}

		context "#game_over" do
			it "returns :winner if winner? is true" do
				board = Board.new
				allow(board).to receive(:winner?) {true}
				expect(board.game_over).to eq :winner
			end

			it "returns :draw if :winner is false and :draw is true" do
				board = Board.new
				allow(board).to receive(:winner?) {false}
				allow(board).to receive(:draw?) {true}
				expect(board.game_over).to eq :draw
			end

			it "returns false if :winner and :draw are both false" do
				board = Board.new
				allow(board).to receive(:winner) {false}
				allow(board).to receive(:draw) {false}
				expect(board.game_over).to eq false
			end

			it "returns :winner when a row has objects with values that are all the same" do
				grid = [
					[x_cell, x_cell, x_cell],
					[y_cell, x_cell, y_cell],
					[y_cell, x_cell, empty]
				]
				board = Board.new( {grid: grid} )
				expect(board.game_over).to eq :winner
			end

			it "returns :winner when a column has objects with values that are all the same" do
				grid = [
					[x_cell, y_cell, y_cell],
					[x_cell, x_cell, y_cell],
					[x_cell, x_cell, empty]
				]
				board = Board.new( {grid: grid} )
				expect(board.game_over).to eq :winner
			end			

			it "returns :winner when a diagonal has objects with values that are all the same" do
				grid = [
					[x_cell, empty, x_cell],
					[y_cell, x_cell, y_cell],
					[y_cell, x_cell, x_cell]
				]
				board = Board.new( {grid: grid} )
				expect(board.game_over).to eq :winner
			end

			it "returns :draw when all cells are filled with no winner" do
				grid = [
					[y_cell, x_cell, y_cell],
					[x_cell, y_cell, x_cell],
					[x_cell, y_cell, x_cell]
				]
				board = Board.new( {grid: grid} )
				expect(board.game_over).to eq :draw
			end

			it "returns false when there is no winner or draw" do
				grid = [
					[y_cell, x_cell, y_cell],
					[x_cell, y_cell, x_cell],
					[x_cell, y_cell, empty]
				]
				board = Board.new( {grid: grid} )
				expect(board.game_over).to eq false
			end						

		end
	end
end