require 'socket'               # Get sockets from stdlib
require 'json'

server = TCPServer.open(2000)  # Socket to listen on port 2000

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

loop {                         # Servers run forever
  client = server.accept       # Wait for a client to connect

  headers = ""
  while line = client.gets
    break if line == "\r\n"
    headers << line
  end

  print headers

  case headers.split(" ")[0]
    when "GET"
      path = ".#{headers.split(" ")[1]}"
      http_ver = headers.split(" ")[2]
      begin
        file = File.open(path, 'r').readlines.map! do |line|
          line.strip
        end
        client.puts "#{http_ver} 200 OK"
        client.puts "Date: #{Time.now.strftime("%a, %d %b %Y %H:%M:%S %Z")}"
        client.puts "Content-Type: #{content_type(path)}"
        client.puts "Content-Length: #{File.stat(path).size}\r\n\r\n"
        client.puts file.join("\n").strip
      rescue
        client.puts "#{http_ver} 404 Not Found"
        client.puts "Date: #{Time.now.strftime("%a, %d %b %Y %H:%M:%S %Z")}"
      end
    when "POST"
      http_ver = headers.split(" ")[2]

      body = ""
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

      client.puts("#{http_ver} 200 OK\r\n")
      client.puts("Date: #{Time.now.strftime("%a, %d %b %Y %H:%M:%S %Z")}\r\n")
      client.puts("Content-Type: #{content_type('./data/thanks_viking.html')}\r\n")
      client.puts("Content-Length: #{File.stat('./data/thanks_viking.html').size}\r\n\r\n")

      client.puts(post_html.join("\r\n"))
    else
  end

client.puts("\r\n")
client.close
}