require "socket"  # need to create 

server = TCPServer.new("localhost", 3003)   #create TCP server on localhost and port #

def get_http_method(request_line)
  request_line.split[0]
end

def get_path(request_line)
  request_line.split[1].split("?")[0]  
end

def get_params(request_line)
  path_and_query_string = request_line.split[1]
  query_string = path_and_query_string.split("?")[1]
  params = {}
  
  query_string.split("&").each do |key_value|
    key = key_value.split("=")[0]
    value = key_value.split("=")[1]
    params[key] = value
  end
end

loop do
  client = server.accept  # waits until someone tries to request something from the server

  request_line = client.gets  # retrieves first line of the request text
  next if !request_line || request_line =~ /favicon/
  puts request_line
  

# GET /?rolls=2&sides=6 HTTP/1.1


  http_method = get_http_method(request_line)
  path = get_path(request_line)
  params = get_params(request_line)
  puts params

  client.puts "HTTP/1.1 200 OK\r\n\r\n"
  client.puts request_line
  params["rolls"].to_i.times do 
    client.puts rand(params["sides"].to_i) + 1
  end
  client.close
end