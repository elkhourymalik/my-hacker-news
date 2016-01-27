# set :bind, '0.0.0.0'

require 'sinatra'
require "sinatra/reloader" if development?
require_relative "config/application.rb"

set :views, proc { File.join(root, "app/views") }





get '/' do
  # TODO: fetch posts from database.
  #       to pass them to the view, store them in an instance variable
  @posts = Post


  erb :posts  # The rendered HTML is in app/views/posts.erb
end

get '/loged' do
  @posts = Post
  erb :loged
end

post '/create_post' do
  name = params["name"]
  url = params["url"]
  full_url = "http://#{url}"
  post = Post.new({name: name, url: full_url})
  post.save
  redirect "/loged"
end

post '/upvote_post/:id' do
  id = params[:id].to_i
  post = Post.find(id)
  post.votes.nil? ? post.votes = 1 : post.votes += 1
  post.save
  redirect "/loged"
end

post '/downvote_post/:id' do
  id = params[:id].to_i
  post = Post.find(id)
  post.votes.nil? || post.votes == 1 ? post.votes = nil : post.votes -= 1
  post.save
  redirect "/loged"
end

get '/login' do
  erb :login
end

post '/login1' do
  username = params["username"]
  password = params["password"]

  user = User.find_by_username("#{username}")
  unless user.nil?
    if user.password == password
      redirect '/loged'
    else
      redirect '/login'
    end
  end
  redirect '/login'
end

post '/create_user' do
  username = params["username"]
  email = params["email"]
  password = params["password"]
  user = User.new({username: username, email: email, password: password})
  user.save
  redirect "/login"
end

get '/get_username' do
  erb :get_username
end

post '/get_username_from_email' do
  email = params["email"]
  user = User.find_by_email("#{email}")
  @username = user.username unless user.nil?
  # @message
  erb :get_username
end





