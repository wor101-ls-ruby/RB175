require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @title = "Monsters"
  @sort = params['sort']
  @contents = Dir.children("public").sort
  @contents.reverse! if @sort == 'descending'
  

  erb :home
end

get "/public" do
  
end