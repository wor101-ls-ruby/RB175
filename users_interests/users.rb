require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do 
  @users_file = YAML.load(File.read("data/users.yaml"))
  @number_of_interests = count_interests

  @footer = "There are #{@users_file.keys.count} users with #{@number_of_interests} interests."
end

helpers do
  def count_interests
    interests = 0
    @users_file.values.each { |hash| interests += hash[:interests].count }
    interests
  end
end

get "/" do
  @title = "Users and Interests"
  
  erb :home
end

get "/user/:name" do
  @user_name = params[:name]
  @user_hash = @users_file[@user_name.to_sym]
  @email = @user_hash[:email]
  @interests = @user_hash[:interests].join(", ")
  @other_users = @users_file.keys.select { |name| name != @user_name.to_sym }
  
  erb :user
end
