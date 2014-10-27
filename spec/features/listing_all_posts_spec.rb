require 'spec_helper'

feature "User browses the list of posts" do
	
	before(:each) {
		
		Post.create( 	post: "BEST POST EVER",
									user_name: "@nic")
		
		User.create( 	email: "nic@pell.com",
								user_name: "@nic",
								password: "fairytail",
								password_confirmation: "fairytail")
	}

	scenario "When visiting the homepage" do
		visit '/'
		expect(page.status_code).to eq 200
		expect(page).to have_content('BEST POST EVER')
	end

	scenario 'a post should display with a user name' do
		visit '/'
		expect(page).to have_content('@nic')
	end
end
