require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'
require_relative 'helpers/application'
require_relative 'data_mapper_setup'
require_relative 'helpers/session'
require_relative 'models/post'
require_relative 'models/user'

# require_relative 'controllers/sessions'
# require_relative 'controllers/users'
# require_relative 'controllers/posts'



include SessionHelpers

set :views, Proc.new { File.join(root, "views") }
enable :sessions
set :session_secret, 'super secret'
use Rack::Flash
set :partial_template_engine, :erb
set :public_folder, 'public'

get '/' do
	@posts = Post.all

	erb :index
end

post '/posts' do
	post = params["post"]
	user_name = session[:user_name]
	Post.create(post: post, user_name: user_name)
	redirect to('/')
end

get '/users/new' do
	@user = User.new
	erb :"users/new"
end

post '/users' do
	@user = User.create(email: params[:email],
											user_name: params[:user_name],
											password: params[:password],
											password_confirmation: params[:password_confirmation])
	if @user.save
		session[:user_id] = @user.id
		session[:user_name] = @user.user_name
		redirect to('/')
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :"users/new"
	end
end

get '/sessions/new' do

	erb :"sessions/new"
end

post '/sessions' do
	email, password, user_name = params[:email], params[:password], params[:user_name]
	@user = User.authenticate(email, password)
	if @user
		session[:user_id] = @user.id
		redirect to('/')
	else
		flash[:errors] = ["The email or password you entered is incorrect"]
		erb :"sessions/new"
	end
end

delete '/sessions' do
	flash[:notice] = "Goodbye!"
	session[:user_id] = nil

	redirect to('/')
end

