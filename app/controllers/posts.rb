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