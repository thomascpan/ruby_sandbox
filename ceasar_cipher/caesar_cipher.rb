def caesar_cipher(text, key)
	letters = text.split('')
	key.times do |i|
		letters = letters.map do |letter|
			if letter =~ /\W/
				letter = letter
			else
				if letter == "z"
					letter = "a"
				elsif letter == "Z"
					letter = "A"
				else 
					letter.next
				end
			end 
		end
	end
	puts letters.join
end


caesar_cipher("Helloz!", 1)
caesar_cipher("Helloz", 2)
caesar_cipher("Helloz! I'm Thomas", 1)

caesar_cipher("I need to test this code muthertrucker!!!", 5)
caesar_cipher("What a string!", 5)
