require "spec_helper"

module ConnectFour
	describe Player do
		let(:player) {Player.new("Player", "X")}
		context "#initialize" do
			it "creates Player objects" do
				expect(player).to be_instance_of Player
			end
		end

		context "#name" do
			it "returns the name" do
				expect(player.name).to eq "Player"
			end
		end

		context "#color" do
			it "returns the color" do
				expect(player.color).to eq "X"
			end
		end
	end
end