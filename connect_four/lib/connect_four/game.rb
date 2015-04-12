module ConnectFour
	class Game
		attr_reader :players, :board, :current_player, :other_player 

		def initialize(players, board = Board.new)
			@players = players
			@board = board
			@current_player, @other_player = players.shuffle
		end

		def switch_players
			@current_player, @other_player = @other_player, @current_player
		end

		def solicit_move
			"#{current_player.name}: Please select a column (0-6) to make your move."
		end

		def get_move
			move = gets.chomp.to_i
			if move < 7 && move >=0
				move
			else
				puts "Invalid input. #{solicit_move}"
				get_move
			end
		end

		def game_over_message(column)
			return "#{current_player.name} won!" if board.game_over(column) == :winner
			return "The game ended in a tie" if board.game_over(column) == :draw
		end

		def play_again?
			puts "Would you like to play again? (Y/N)"
			answer = gets.chomp.upcase
			if answer == "Y"
				ConnectFour::Game.new(players).play
			else
				puts "Goodbye!"
			end
		end

		def play
			puts "Welcome to ConnectFour"
			puts ""
			puts "#{current_player.name} has been randomly selected to go first!"
			puts ""
			while true
				board.formatted_grid
				puts ""
				puts solicit_move
				column = get_move
				if board.set_column(column, current_player.color)
				else
					switch_players
				end
				if board.game_over(column)
					puts game_over_message(column)
					board.formatted_grid
					play_again?
					return
				else
					switch_players
				end
			end
		end
	end
end