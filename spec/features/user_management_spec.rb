require 'spec_helper'



feature 'User signs up' do
	
	scenario "when being logged out" do
		expect{ sign_up }.to change(User, :count).by(1)
		expect(page).to have_content("Welcome, @nic")
		expect(User.first.email).to eq("nic@pell.com")
		expect(User.first.user_name).to eq("@nic")
	end

	scenario "with a password that doesn't match" do
		expect{ sign_up('nic@pell.com', 'pass', 'wrong') }.to change(User, :count).by(0)
		expect(current_path).to eq('/users')
		expect(page).to have_content("Sorry, your passwords don't match")
	end

	scenario "with an email that is already registered" do
		expect{ sign_up }.to change(User, :count).by(1)
		expect{ sign_up }.to change(User, :count).by(0)
		expect(page).to have_content("This email is already registered")
	end

	scenario "with a user name that is already registered" do
		expect{ sign_up }.to change(User, :count).by(1)
		expect{ sign_up }.to change(User, :count).by(0)
		expect(page).to have_content("This username is already registered")
	end

end

feature 'User signs in' do
	
	before(:each) do
		User.create(email: "nic@pell.com",
								user_name: "@nic",
								password: "fairytail",
								password_confirmation: "fairytail")
	end

	scenario 'with correct credentials' do
		visit '/'
		expect(page).not_to have_content('Welcome, @nic')
		sign_in('nic@pell.com', 'fairytail')
		expect(page).to have_content('Welcome, @nic')
	end

	scenario 'with incorrect credentials' do
		visit '/'
		expect(page).not_to have_content('Welcome, @nic')
		sign_in('nic@pell.com', 'deathnote')
		expect(page).not_to have_content('Welcome, @nic')
	end

end

feature 'User signs out' do

	before(:each) do
		User.create(email: "nic@pell.com",
								password: "fairytail",
								password_confirmation: "fairytail")
	end

	scenario 'while being signed in' do
		sign_in('nic@pell.com', 'fairytail')
		click_button 'Sign out'
		expect(page).to have_content('Goodbye!')
		expect(page).not_to have_content('Welcome, nic@pell.com')
	end

end