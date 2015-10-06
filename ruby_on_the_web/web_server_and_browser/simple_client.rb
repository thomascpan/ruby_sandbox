require 'socket'
require 'json'
 
host = 'localhost'     # The web server
port = 2000                           # Default HTTP port 

def action_request(host, port)
	socket = TCPSocket.open(host,port)
	puts "Choose whether to GET or POST."
	action = gets.chomp.downcase
	if action == 'get'
		get_index(socket)
	elsif action == 'post'
		post_viking(socket)
	else
		puts "Invalid input. Try again"
		return action_request(host, port)
	end
end


def get_index(socket)
	path = "/index.html"
	request = "GET #{path} HTTP/1.0\r\n\r\n"
	socket.puts(request)
	response = socket.read
	print response
end

def post_viking(socket)
	path = "/index.html"

	puts "What's your name?"
	name = gets.strip
	puts "What's your email?"
	email = gets.strip
	data = {:viking => {:name => name, :email => email} }.to_json

	file = File.new('./data/viking.json', 'w')
	file.puts(data)
	file.close

	h1 = "POST #{path} HTTP/1.0"
	h2 = "From: thomascpan@gmail.com"
	h3 = "User-Agent: VikingBash"
	h4 = "Content-Type: text/json"
	h5 = "Content-length #{File.stat('./data/viking.json').size}"

	request = "#{h1}\r\n#{h2}\r\n#{h3}\r\n#{h4}\r\n#{h5}\r\n\r\n#{data}\r\n\r\n"
	socket.puts(request)
	response = socket.read
	print response
end

action_request(host, port)