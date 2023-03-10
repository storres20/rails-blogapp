require 'rails_helper'

RSpec.describe 'Post testing', type: :feature do
  describe 'index page' do
    before(:example) do
      @user = User.create(name: 'Italo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Developer',
                          posts_counter: 1)
      @post = Post.create(title: 'Machine Learning', text: 'First post', comments_counter: 2, likes_counter: 1,
                          author: @user)
      @first_comment = Comment.create(text: 'First comment', author: @user, post: @post)
      @second_comment = Comment.create(text: 'Second comment', author: @user, post: @post)
      Like.create(author: @user, post: @post)
      visit user_posts_path(user_id: @user.id)
    end
    it "should render the user's profile picture" do
      expect(page).to have_xpath("//img[@src = '#{@post.author.photo}' ]")
    end

    it "should render the user's username" do
      expect(page).to have_content(@post.author.name)
    end

    it 'should render the number of posts the user has written' do
      expect(page).to have_content(@post.author.posts_counter)
    end

    it "should render a post's title" do
      expect(page).to have_content(@post.title)
    end

    it "should render some of the post's body" do
      expect(page).to have_content(@post.text)
    end

    it 'should render the first comments on a post' do
      expect(page).to have_content('First comment')
    end

    it 'should render how many comments a post has' do
      expect(page).to have_content(@post.comments_counter)
    end

    it 'should render how many likes a post has' do
      expect(page).to have_content(@post.likes_counter)
    end

    it 'should render a section for pagination if there are more posts than fit on the view' do
      expect(page).to have_content('Pagination')
    end

    it "should redirect to that post's show page" do
      click_link @post.text
      expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @post.id))
    end
  end
end
