module SessionHelpers

	def sign_up(email = "nic@pell.com",
							user_name = "@nic",
							password = "fairytail", 
							password_confirmation = "fairytail")
			visit '/users/new'
			expect(page.status_code).to eq(200)
			fill_in :email, with: email
			fill_in :user_name, with: user_name
			fill_in :password, with: password
			fill_in :password_confirmation, with: password_confirmation
			click_button "Sign up"
	end

	def sign_in(email, password)
		visit '/sessions/new'
		fill_in 'email', with: email
		fill_in 'password', with: password
		click_button 'Sign in'
	end

	def add_post(post)
			visit '/'
			sign_in('nic@pell.com', 'fairytail')
			fill_in 'post', with: 'AN EVEN BETTER POST THAN THE BEST POST'
			click_button 'Post'
	end

end