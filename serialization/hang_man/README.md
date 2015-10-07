Project: Hangman

Link: http://www.theodinproject.com/ruby-programming/file-i-o-and-serialization

Description: A Command Line Interface of [Hangman](https://en.wikipedia.org/wiki/Hangman_(game)).

Author(s): Thomas Pan

Instructions: Run game with `$ruby lib/hang_man.rb`. 

###Gameplay

```
Game menu has four options: (l)oad a game, (s)tart a new game, (d)elete a game, or (q)uit. 

Enter first the first letter of the option to proceed. 

#### Load/Delete ####

Load or Delete a saved game by entering the file name. Ex. game_01.yaml


#### Save ####

Save a game by entering the file name without file format. Ex. game_01


#### Start ####

A random word will be generated. 
Player loses if they make reach 8 incorrect guesses. 

To make a guess enter one letter, case insensitive. 

Ex. 

 *secret word*   *wrong*  *wrong letters*
  		 guesses

_ _ _ _ _ _ _ _ _ | 0 | 

e _ _ _ _ _ _ _ _ | 1 | y u s r d m c
.
.
.
e _ o _ i o _ _ _ | 7 | y u s r d m c

```
