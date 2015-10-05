def substrings(phrase, dictionary)
	phrase.downcase! #Makes into case insensitive
	frequencies = Hash.new(0) #create hash to store answers
	
	# check if phrase includes dictionary word. If so add to hash. If not, do nothing. 
	dictionary.each do |word|
		temp_phrase = phrase #need temp phrase to prevent altering orignal phrase
		while temp_phrase.include?(word)
			frequencies[word] += 1
			temp_phrase = temp_phrase.sub(word, '')
		end 
	end
	puts frequencies
end


dictionary = ["below", "down", "go", "going", "horn", "how", "howdy", "it", "i", "low", "own", "part", "partner", "sit"]
substrings("below", dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary)