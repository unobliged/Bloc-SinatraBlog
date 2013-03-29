require "rubygems"
require "sinatra"
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")

class Post
  include DataMapper::Resource
  property :id, Serial
  property :post, Text
  property :num_ch, Text
  property :cur_date, Text
end

DataMapper.finalize.auto_upgrade!

get '/' do
	erb :wireframe
end

get '/index' do
	@posts = Post.all 
	erb :index
end

get '/:id' do
	if Post.get(params[:id]).nil?
		redirect '/'
	else
		@cur_post = Post.get params[:id]
		erb :view
	end
end

post '/quickpost' do
	@post = Post.new
	@post.post = params[:text]
  @post.num_ch = params[:text].length.to_s
	@post.cur_date = Time.now.to_s
	@post.save
	@posts = Post.all 
	redirect '/index'
	#"<p>Post: #{params[:text]}</p> <p>Number of characters: #{@num_ch}</p> <p>Date/Time of Post: #{@cur_date}</p>"
end

post '/edit/:id' do
	@edit_post = Post.get params[:id]
	@edit_post.post = params[:text]
	@edit_post.save
	redirect "/#{params[:id]}"
end
