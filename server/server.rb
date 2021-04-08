require "socket"  # need to create 

server = TCPServer.new("localhost", 3003)   #create TCP server on localhost and port #
loop do
  client = server.accept  # waits until someone tries to request something from the server

  request_line = client.gets  # retrieves first line of the request text
  puts request_line
  
  client.puts "HTTP/1.1 200 OK\r\n\r\n"
  client.puts request_line
  client.close
end