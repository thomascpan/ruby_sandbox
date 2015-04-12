require_relative "../lib/connect_four.rb"


player_one = ConnectFour::Player.new("Player One", "X")
player_two = ConnectFour::Player.new("Player Two", "O")
players = [player_one, player_two]
ConnectFour::Game.new(players).play