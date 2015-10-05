require_relative "../lib/tic_tac_toe.rb"

puts "Welcome to tic tac toe"
player_x = TicTacToe::Player.new({color: "X", name: "player_x"})
player_o = TicTacToe::Player.new({color: "O", name: "player_o"})
players = [player_x, player_o]
TicTacToe::Game.new(players).play
