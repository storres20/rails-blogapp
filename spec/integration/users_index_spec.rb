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
end
