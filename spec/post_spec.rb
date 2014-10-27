require 'spec_helper'


describe Post do
	
	context 'Checking datamapper is working' do

		it 'should be created and retrieved from the database' do
			expect(Post.count).to eq(0)
			Post.create( post: 'BEST POST EVER')
			expect(Post.count).to eq(1)
			post = Post.first

			expect(post.post).to eq('BEST POST EVER')

			post.destroy

			expect(Post.count).to eq(0)
		end
	end
end
