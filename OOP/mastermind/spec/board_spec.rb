require "helper_spec"

module Mastermind
	describe Board do

		context "#initialize" do
			it "initializes a board with a grid" do
				input = Board.new
				expect {input}.to_not raise_error
			end

			it "sets grid to 13 rows by default" do
				input = Board.new
				expect(input.grid.size).to eq 13
			end

			it "sets first twelve rows in the gird to hold two things" do
				input = Board.new
				input.grid[0..11].each do |row|
					expect(row.size).to eq 2
				end
			end

			it "sets last row in the grid to hold one thing" do
				input = Board.new
				expect(input.grid[12].size).to eq 1
			end

			it "sets each subrow of the first twelve rows to hold 4 things" do
				input = Board.new
				input.grid[0..11].each do |row|
					row.each do |subrow|
						expect(subrow.size).to eq 4
					end
				end
			end

			it "sets subrow of last row to hold 4 things" do
				input = Board.new
				expect(input.grid[12][0].size).to eq 4
			end						
		end

		context "#grid" do 
			it "returns the grid" do
				input = Board.new(grid: "blah")
				expect(input.grid).to eq "blah"
			end
		end

		context "#get_guess" do
			it "returns the array of a guess at a given round" do
				grid = [[['', '', '', ''], ['', '', '',  'hello']]]
				input = Board.new(grid: grid)
				round = 0
				expect(input.get_guess(round)).to eq ['', '', '', '']	
			end
		end

		context "#set_guess" do
			it "changes the values of an array of a guess at a given round " do
				Cat = Struct.new(:value)
				grid = [[[Cat.new(""), Cat.new(""), Cat.new(""), Cat.new("")], ['', '', '', '']]]
				input = Board.new(grid: grid)
				input.set_guess(0, "meow")
				x = input.get_guess(0).map {|cell| cell.value}
				expect(x.join).to eq "meow"
			end
		end

		# Works correctly, but do not know how to test. 
		context "#solution" do
			it "returns randomly generated solution" do
				input = Board.new
				solution_array = ["R", "O", "Y", "G"]
				expect(input.solution). to eq ["R", "O", "Y", "G"]
			end
		end

		context "#game_over" do
			it "returns :winner if winner? is true" do
				input = Board.new
				allow(input).to receive(:winner?) {true}
				expect(input.game_over).to eq :winner
			end

			it "returns false if winner? is false and loser? is false" do
				input = Board.new
				allow(input).to receive(:winner?) {false}
				allow(input).to receive(:loser?) {false}
				expect(input.game_over).to eq false
			end

			it "returns :loser if winner? is false and loser? is true" do
				input = Board.new
				allow(input).to receive(:winner?) {false}
				allow(input).to receive(:loser?) {true}
				expect(input.game_over).to eq :loser
			end
		end

		# I think it's working, but do not know how to test. 
		context "#hint" do 
			it "returns a hint array based off guess" do
				input = Board.new
				solution = ["O", "R", "R", "R"]
				expect(input.hint("RORB")).to eq ["B", "W", "W"]
			end
		end
	end
end