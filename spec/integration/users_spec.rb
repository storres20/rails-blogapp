require 'rails_helper'

RSpec.describe 'User Page', type: :feature do
  describe 'index page' do
    before(:example) do
      @user = User.create(name: 'Jim',
                          photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Developer', posts_counter: 1)
      visit users_path
    end

    it 'should render the username of all other users.' do
      User.all.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it 'should render the profile picture of each user.' do
      User.all.each do |user|
        expect(page).to have_xpath("//img[@src = '#{user.photo}' ]")
      end
    end

    it 'should render the number of posts each user has written' do
      User.all.each do |user|
        expect(page).to have_content(user.posts_counter)
      end
    end

    it "When I click on a user, I am redirected to that user's show page" do
      click_link @user.name
      expect(page).to have_current_path(user_path(@user.id))
    end
  end

  describe 'show page' do
    before(:example) do
      @user = User.create(name: 'Jim',
                          photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Developer', posts_counter: 3)
      @first_post = Post.create(title: 'First', text: 'First post', comments_counter: 1, likes_counter: 1,
                                author: @user)
      @second_post = Post.create(title: 'Second', text: 'Second post', comments_counter: 1, likes_counter: 1,
                                 author: @user)
      @third_post = Post.create(title: 'Third', text: 'Third post', comments_counter: 1, likes_counter: 1,
                                author: @user)
      visit user_path(id: @user.id)
    end
    it "should render the user's profile picture" do
      expect(page).to have_xpath("//img[@src = '#{@user.photo}' ]")
    end

    it "should render the user's username" do
      expect(page).to have_content(@user.name)
    end

    it 'should render the number of posts the user has written' do
      expect(page).to have_content(@user.posts_counter)
    end

    it "should render the user's bio" do
      expect(page).to have_content(@user.bio)
    end

    it "should render the user's first 3 posts" do
      expect(page).to have_content(@first_post.text)
      expect(page).to have_content(@second_post.text)
      expect(page).to have_content(@third_post.text)
    end

    it "should have a button that lets me view all of a user's posts" do
      expect(page).to have_link('See all posts', href: user_posts_path(user_id: @user.id))
    end

    it "When I click a user's post, it redirects me to that post's show page" do
      click_link @first_post.text
      expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @first_post.id))
    end

    it 'should redirects to all posts show page.' do
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(user_id: @user.id))
    end
  end
end
