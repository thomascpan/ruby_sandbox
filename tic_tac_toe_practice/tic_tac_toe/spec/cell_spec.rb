require "helper_spec"

module TicTacToe
	describe Cell do 
		context "#initialize" do
			it "is initialize with a value of '' by default" do
				x = Cell.new()
				expect(x.value).to eq ''
			end
		end
	end
end