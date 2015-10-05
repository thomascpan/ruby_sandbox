module Mastermind
	class Game
		attr_reader :board
		def initialize(board = Board.new)
			@board = board
		end

		def solicit_move
			"#Enter a combination of four colors to make your move"
		end

		# Gets move from user
		def get_move
			gets.upcase.chomp
		end

		def game_over_message
			return "You win!" if board.game_over == :winner
			return "You lose!" if board.game_over == :loser
		end

		def play
			instructions
			board.solution
			round = 0
			while true
				board.formatted_grid
				puts ""
				puts solicit_move
				guess = get_move
				board.set_guess(round, guess)
				hint = board.hint(guess)
				board.set_hint(round, hint)
				round+=1
				if board.game_over(round)
					puts game_over_message
					board.formatted_grid
					return
				end
			end
		end

		private

		def instructions
			puts "The object..."
			puts "The computer has selected a secret combination of 4 colored pegs and you have to guess that combination in 12 or fewer tries to win."
			puts "How to  play.."
			puts "Enter a combination of colors. Once you have entered a combination, the computer will provide feedback in the form of two colors."
			puts "A black peg indicates that one of your pegs is the right color in the right position."
			puts "A white peg indicates that one of your pegs is the right color but in the wrong position."
			puts "Good luck!"			
		end
	end
end