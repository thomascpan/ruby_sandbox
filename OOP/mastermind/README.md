Project: Master Mind

Link: http://www.theodinproject.com/ruby-programming/oop

Description: A Command Line Interface of [Mastermind](https://en.wikipedia.org/wiki/Mastermind_(board_game)).

Author(s): Thomas Pan

Instructions: Run game with `$ruby example/example_game.rb`. 

###Gameplay

```
A secret combination of four colors is randomly selected out of a total of six possible color choices.
Red(R), Orange(O), Yellow(Y), Green(G), Indigo(I), and Violet(V).
Colors can be reapeated. 

The player has 12 guesses to crack the code. After each guess, the computer will provide hints in the form of two pegs. 
A Black(B) peg means that one of the colors guessed is the correct color and in the correct position. 
A White(W) peg means that one of the colors is correct, but in the wrong position. 

Guesses are entered by the first letter of the color only, case insensitive. 
Example: ROYG or royg. 

_ _ _ _ _ _ _ _ 	Rows 1-12 represent each round or guess. 
_ _ _ _ _ _ _ _ 	Left 4 columns represent guesses, and
_ _ _ _ _ _ _ _ 	right 4 columns represent hints.
_ _ _ _ _ _ _ _ 	
_ _ _ _ _ _ _ _ 	The last row represents the solution. 
_ _ _ _ _ _ _ _ 	Solution will be revealed when the
_ _ _ _ _ _ _ _ 	game is over. 
_ _ _ _ _ _ _ _ 
_ _ _ _ _ _ _ _ 
_ _ _ _ _ _ _ _ 
_ _ _ _ _ _ _ _ 
_ _ _ _ _ _ _ _ 
_ _ _ _

Example:

R R R R _ _ _ _
O O O O B B _ _ 	
Y Y Y Y B B _ _ 	
O O Y Y B B W W 	
O Y O Y W W W W 
Y O Y O B B B B 
_ _ _ _ _ _ _ _ 
_ _ _ _ _ _ _ _ 
_ _ _ _ _ _ _ _ 
_ _ _ _ _ _ _ _ 
_ _ _ _ _ _ _ _ 
_ _ _ _ _ _ _ _ 
Y O Y 0

```
