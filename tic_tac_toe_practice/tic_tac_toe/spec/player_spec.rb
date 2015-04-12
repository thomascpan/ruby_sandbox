require "helper_spec"

module TicTacToe
	describe Player do 
		context "#initialize" do
			it "raises an exception when initialized with {}" do 
				expect { Player.new({}) }.to raise_error
			end

			it "does not raise an exception when initialized with valid input hash" do
				expect { Player.new({name: "bob", color: "red"}) }.to_not raise_error
			end

			it "returns the name" do
				x = Player.new({name: "bob", color: "red"})
				expect(x.name).to eq "bob"
			end
			it "returns the color" do
				x = Player.new({name: "bob", color: "red"})
				expect(x.color).to eq "red"
			end			
		end
	end
end