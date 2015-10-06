require 'jumpstart_auth'
require 'bitly'

class MicroBlogger
	attr_reader :client

	def initialize
		puts "Initializing"
		@client = JumpstartAuth.twitter
	end

	def tweet(message)
		if message.size <= 140
			@client.update(message)
		else
			puts "Error: Tweets cannot exceed 140 characters."
		end
	end

	def run
		puts "Welcome to the JSL Twitter Client!"
		command = ''
		while command != 'q'
			print 'enter command: '
			input = gets.chomp
			parts = input.split(' ')
			command = parts[0]
			case command
				when 'q' then puts "Goodbye!"
				when 't' then tweet(parts[1..-1].join(" "))
				when 'dm' then dm(parts[1], parts[2..-1].join(" "))
				when 'spam' then spam_my_followers(parts[1..-1].join(" "))
				when 'elt' then everyones_last_tweet
				when 's' then shorten(parts[1])
				when 'turl' then tweet(parts[1..-2].join(' ') + " " + shorten(parts[-1]))
				else
					puts "Sorry, I don't know how to #{command}"
			end
		end
	end

	def dm(target, message)
		screen_names = followers_list
		puts "Trying to send #{target} this direct message:"
		puts message
		if screen_names.include?(target)
			message = "d @#{target} #{message}"
			tweet(message)
		else
			puts "Error: Can only DM followers."
		end
	end

	def followers_list
		screen_names = @client.followers.collect{ |follower| @client.user(follower).screen_name }
	end

	def spam_my_followers(message)
		followers_list.each do |follower|
			dm(follower, message)
		end
	end

	def everyones_last_tweet
		friends = @client.friends
		friends.each do |friend|
			friend_name = @client.user(friend).screen_name
			friend_status = @client.user(friend).status.text
			friend_timestamp = @client.user(friend).status.created_at
			puts "#{friend_name} said this on #{friend_timestamp.strftime("%A, %b, %d")}..."
			puts friend_status
		end
	end

	def shorten(original_url)
		Bitly.use_api_version_3
    bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')  
    puts "Shortening this URL: #{original_url}"
    return bitly.shorten(original_url).short_url
	end
end

blogger = MicroBlogger.new
blogger.run