require 'socket'
require 'json'

host = 'localhost'
port = 2000


def main(host, port)
	socket = TCPSocket.open(host, port)
	puts "What would you like to do? (GET or POST)"
	action = gets.chomp.upcase
	case action
		when 'GET'
			get_index(socket)
		when 'POST'
			post_viking(socket)
		else
	end
end

def get_index(socket)
	path = "/index.html"
	request = "GET #{path} HTTP/1.0\r\n\r\n"
	socket.print(request)
	response = socket.read
	print response
end

def post_viking(socket)
	path = "/index.html"
	
	puts "What's your name?"
	name = gets.chomp
	puts "What's your email?"
	email = gets.chomp
	data = {:viking => {:name => name, :email => email}}.to_json

	file = File.new('./data/viking.json', 'w')
	file.puts data
	file.close

	h1 = "POST #{path} HTTP/1.0"
	h2 = "From: thomascpan@gmail.com"
	h3 = "User-Agent: VikingBash"
	h4 = "Content-Type: text/json"
	h5 = "Content-Length: #{File.stat('./data/viking.json').size}"

	request = "#{h1}\r\n#{h2}\r\n#{h3}\r\n#{h4}\r\n#{h5}\r\n\r\n#{data}\r\n\r\n"
	socket.print(request)
	response = socket.read
	print response
end

main(host, port)
