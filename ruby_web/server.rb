require 'socket'
require 'json'

server = TCPServer.open(2000)

def content_type(path)
	case path.split(".")[2].strip
		when "html"
			content_type = "text/html"
		when "htm"
			content_type = "text/htm"
		else
			content_type = "unknown"
	end
	return content_type
end

while true
	client = server.accept

	headers = ''
	while line = client.gets
		break if line == "\r\n"
		headers << line
	end

	puts headers
	method = headers.split(' ')[0]
	path = ".#{headers.split(' ')[1]}"
	http_vers = headers.split(' ')[2]

	case method
		when 'GET'
			begin
				contents = File.open("#{path}", "r") { |file| file.read }			
				client.puts "#{http_vers} 200 OK\r\n"
				client.puts "Date: #{Time.now.strftime("%a, %d %b %Y %H:%M:%S %Z")}\r\n"
				client.puts "Content-Type: #{content_type(path)}\r\n"
				client.puts "Content-Length: #{File.stat(path).size}\r\n\r\n"
				client.puts contents
			rescue
				client.puts "#{http_vers} 404 Not Found\r\n"
				client.puts "Date: #{Time.now.strftime("%a, %d %b %Y %H:%M:%S %Z")}\r\n"
			end

		when 'POST'
			body = ''
			while line = client.gets
				break if line == "\r\n"
				body << line
			end

			print body

			params = JSON.parse(body)
			data = "<li>Name: #{params['viking']['name']}</li>\r\n<li>Email: #{params['viking']['email']}</li>"

			post_html = File.open('./thanks.html', 'r').readlines.map! { |line| line.strip }
			post_html[post_html.index("<%= yield %>")] = data

			file = File.new('./data/thanks_viking.html', 'w')
			file.puts(post_html.join("\r\n"))
			file.close

			client.puts "#{http_vers} 200 OK\r\n"
			client.puts "Date: #{Time.now.strftime("%a, %d %b %Y %H:%M:%S %Z")}\r\n"
			client.puts "Content-Type: #{content_type(path)}\r\n"
			client.puts "Content-Length: #{File.stat(path).size}\r\n\r\n"
			client.puts post_html
		else

	end






	client.close
end