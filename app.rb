require "rubygems"
require "sinatra"

get '/' do
	erb :wireframe
end

get '/post' do
  @num_ch = params[:text].length.to_s
	@cur_date = Time.now.to_s
	"<p>Post: #{params[:text]}</p> <p>Number of characters: #{@num_ch}</p> <p>Date/Time of Post: #{@cur_date}</p>"
end
