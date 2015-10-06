require "spec_helper"

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

		context "#get_guess" do
			it "returns the array of a guess at a given round" do
				input = Board.new
				round = 0
				input.get_guess(round).each do |e|
					expect(e.value).to eq nil
				end
			end
		end

		context "#set_guess" do
			it "changes the values of an array of a guess at a given round " do
				input = Board.new
				input.set_guess(0, "meow")
				x = input.get_guess(0).map {|cell| cell.value }
				expect(x.join).to eq "meow"
			end
		end
	end
end