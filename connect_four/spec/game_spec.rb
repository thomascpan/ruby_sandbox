require "spec_helper"

module ConnectFour
	describe Game do

		let(:player_one) { Player.new("Player One", "X") }
		let(:player_two) { Player.new("Player Two", "O") }

		context "#initialize" do
			it "randomly selects a current_player" do
				allow_any_instance_of(Array).to receive(:shuffle) { [player_one, player_two] }
				game = Game.new([player_one, player_two])
				expect(game.current_player).to eq player_one
			end

			it "randomly selects an other_player" do
				allow_any_instance_of(Array).to receive(:shuffle) { [player_one, player_two] }
				game = Game.new([player_one, player_two])
				expect(game.other_player).to eq player_two
			end
		end

		context	"#switch_players" do
			it "sets @current_player to @other_player" do
				allow_any_instance_of(Array).to receive(:shuffle) { [player_one, player_two] }
				game = Game.new([player_one, player_two])
				game.switch_players
				expect(game.current_player).to eq player_two
			end

			it "sets @other_player to @current_player" do
				allow_any_instance_of(Array).to receive(:shuffle) { [player_one, player_two] }
				game = Game.new([player_one, player_two])
				game.switch_players
				expect(game.other_player).to eq player_one
			end
		end

		context "#solicit_move" do
			it "asks the current_player to make a move" do
				allow_any_instance_of(Array).to receive(:shuffle) { [player_one, player_two] }
				game = Game.new([player_one, player_two])
				expected = "Player One: Please select a column (0-6) to make your move."
				expect(game.solicit_move).to eq expected
			end
		end

		context "#game_over_message" do		
			it "returns '{current_player.name} won!' if board shows a winner" do				
				game = Game.new([player_one, player_two])	
				allow(game).to receive(:current_player) { player_one }
				allow(game.board).to receive(:game_over) { :winner }
				expect(game.game_over_message(0)).to eq "Player One won!"
			end

			it "returns 'The game ended in a tie' if board shows a draw" do
				game = Game.new([player_one, player_two])
				allow(game).to receive(:current_player) { player_one }
				allow(game.board).to receive(:game_over) { :draw }
				expect(game.game_over_message(0)).to eq "The game ended in a tie"
			end			
		end
	end
end