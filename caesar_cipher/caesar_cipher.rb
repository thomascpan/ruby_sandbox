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
	letters.join
end
