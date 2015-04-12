require "helper_spec"

module Mastermind
	describe Cell do

		context "#initialize" do
			it "initialize with no value as default" do
				input = Cell.new()
				expect(input.value).to eq ""
			end

			it "initialize with value 'blue'" do
				input = Cell.new("blue")
				expect(input.value).to eq "blue"
			end
		end
	end
end