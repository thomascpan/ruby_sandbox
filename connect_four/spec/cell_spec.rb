require "spec_helper"

module ConnectFour
	describe Cell do
		let(:cell) { Cell.new }
		context "#initialize" do
			it "creates a new Cell object" do
				expect(cell).to be_instance_of Cell
			end

			it "initializes a value of 'nil' by default" do
				expect(cell.value).to eq nil
			end

			it "initializes a value of 'X'" do
				cell_with_value = Cell.new("X")
				expect(cell_with_value.value).to eq "X"
			end
		end
	end
end