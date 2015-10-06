require 'socket'
require 'json'

def main(host, port)
	socket = TCPSocket.open(host, port)

	puts "Which type of request do you want to send? (post or get)"
	case gets.downcase.strip
		when 'get'
			get_index(socket)
		when 'post'
			post_viking(socket)
		else
			puts "Invalid input. Try again."
			return main(host, port)
	end
end

def get_index(socket)
	path = "/index.html"

	request = "GET #{path} HTTP/1.0\r\n\r\n"
	socket.puts(request)

	while line = socket.gets
		puts line
	end
end

def post_viking(socket)
	path = "/index.html"

	puts "Nice, let's do on a raid. What's your name?"
	name = gets.strip
	puts "Hi #{name}, what's your email?"
	email = gets.strip
	data = {:viking => {:name => name, :email => email} }.to_json

	file = File.new('./data/viking.json','w')
	file.puts(data)
	file.close

	h1 = "POST #{path} HTTP/1.0"
	h2 = "From: sahildagarwal@gmail.com"
	h3 = "User-Agent: VikingBash"
	h4 = "Content-Type: text/json"
	h5 = "Content-length #{File.stat('./data/viking.json').size}"

	request = "#{h1}\r\n#{h2}\r\n#{h3}\r\n#{h4}\r\n#{h5}\r\n\r\n#{data}\r\n\r\n"
	socket.puts(request)

	while line = socket.gets
		puts line
	end
end

host = 'localhost'
port = 9999

main(host, port)


