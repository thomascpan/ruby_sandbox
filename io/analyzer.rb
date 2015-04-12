lines = File.readlines(ARGV[0])
line_count = lines.size
text = lines.join

# Count the characters
character_count = text.size
total_characters_nospaces = text.gsub(/\s+/, '').length

# Count the words, sentences, and paragraphs
word_count = text.split.size
sentence_count = text.split(/[.!?]/).size
paragraph_count = text.split(/\n\n/).size

# Make a list of words in the text that aren't stop words,
# count them, and work out the percentages of non-stop words
# against all words
stopwords = %w{the a by on for of are with just but and to the my I has some in}
words = text.split
keywords = words.select { |word| !stopwords.include?(word) }
percentage_of_useful_words = ((keywords.size.to_f / word_count.to_f) * 100).to_i

# Summarize the text by cherry picking some choice sentences
sentences = text.gsub(/\s+/, ' ').strip.split(/\.|\?|!/)
sentences_sorted = sentences.sort_by { |sentence| sentence.length }
one_third = sentences_sorted.length / 3
ideal_sentences = sentences_sorted.slice(one_third, one_third + 1)
ideal_sentences = ideal_sentences.select { |sentence| sentence =~ /is|are/ }

avg_words_per_sentence = word_count / sentence_count
avg_sentence_per_paragraph = sentence_count / paragraph_count

puts "#{character_count} characters"
puts "#{total_characters_nospaces} characters excluding spaces"
puts "#{line_count} lines"
puts "#{word_count} words"
puts "#{sentence_count} sentences"
puts "#{paragraph_count} paragraphs"
puts "average #{avg_words_per_sentence} words per sentence"
puts "average #{avg_sentence_per_paragraph} sentences per paragraph"
puts "#{percentage_of_useful_words}% of useful words"
puts "Summary:\n\n" + ideal_sentences.join('. ')