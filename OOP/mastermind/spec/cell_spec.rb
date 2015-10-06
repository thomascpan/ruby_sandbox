require "spec_helper"

module Mastermind
	describe Cell do

		context "#initialize" do
			it "initialize with no value as default" do
				input = Cell.new()
				expect(input.value).to eq nil
			end

			it "initialize with value 'blue'" do
				input = Cell.new("blue")
				expect(input.value).to eq "blue"
			end
		end
	end
end