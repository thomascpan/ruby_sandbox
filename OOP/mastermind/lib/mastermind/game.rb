module Mastermind
	class Game
		attr_reader :board

		def initialize(board = Board.new)
			@board = board
		end

		def solicit_move
			"Enter a combination of four colors to make your move. i.e. 'ROYG'"
		end

		# Gets move from user
		def get_move
			gets.upcase.chomp
		end

		def game_over_message(round, the_hint)
			return "You win!" if board.game_over?(round, the_hint) == :winner
			return "You lose!" if board.game_over?(round, the_hint) == :loser
		end

		def play
			instructions
			puts ''
			round = 0
			while true
				board.formatted_grid
				puts ""
				puts solicit_move
				guess = get_move
				board.set_guess(round, guess)
				the_hint = board.hint(guess)
				board.set_hint(round, the_hint)
				round+=1
				if board.game_over?(round, the_hint)
					puts game_over_message(round, the_hint)
					board.set_solution
					board.formatted_grid
					return false
				end
			end
		end

			private

			def instructions
				puts "The computer has selected a secret combination of 4 colored pegs and you have to guess that combination in 12 or fewer tries to win."
				puts ""
				puts "Enter a combination of colors. Once you have entered a combination, the computer will provide feedback in Black and White."
				puts ""
				puts "The available colors are: Red(R), Orange(O), Yellow(Y), Green(G), Indigo(I), and Violet(V)."
				puts "A Black(B) peg indicates that one of your pegs is the right color in the right position."
				puts "A White(W) peg indicates that one of your pegs is the right color but in the wrong position."
				puts ""
				puts "Good luck!"			
			end
	end
end