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