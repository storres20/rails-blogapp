require "rails_helper"

RSpec.describe "Post testing", type: :feature do
  describe "index page" do
    before(:example) do
      @user = User.create(name: "Italo", photo: "https://fastly.picsum.photos/id/502/200/200.jpg?hmac=c6mcZ5mcmjadIeDKaJClpvPz9R9-X9q6c0Un-n73Kv4", bio: "Frontend-Developer",
                          posts_counter: 1)
      @post = Post.create(title: "Machine Learning", text: "First post", comments_counter: 2, likes_counter: 1, author: @user)
      @first_comment = Comment.create(text: "First comment", author: @user, post: @post)
      @second_comment = Comment.create(text: "Second comment", author: @user, post: @post)
      Like.create(author: @user, post: @post)
      visit user_posts_path(user_id: @user.id)
    end
    it "should render the user's profile picture" do
      expect(page).to have_xpath("//img[@src = '#{@post.author.photo}' ]")
    end

    it "should render the user's username" do
      expect(page).to have_content(@post.author.name)
    end

    it "should render the number of posts the user has written" do
      expect(page).to have_content(@post.author.posts_counter)
    end

    it "should render a post's title" do
      expect(page).to have_content(@post.title)
    end

    it "should render some of the post's body" do
      expect(page).to have_content(@post.text)
    end

    it "should render the first comments on a post" do
      expect(page).to have_content("First comment")
    end

    it "should render how many comments a post has" do
      expect(page).to have_content(@post.comments_counter)
    end

    it "should render how many likes a post has" do
      expect(page).to have_content(@post.likes_counter)
    end

    it "should render a section for pagination if there are more posts than fit on the view" do
      expect(page).to have_content("Pagination")
    end

    it "should redirect to that post's show page" do
      click_link @post.text
      expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @post.id))
    end
  end

  describe "show page" do
    before(:example) do
      @user1 = User.create(name: "Italo", photo: "https://fastly.picsum.photos/id/502/200/200.jpg?hmac=c6mcZ5mcmjadIeDKaJClpvPz9R9-X9q6c0Un-n73Kv4", bio: "Frontend-Developer",
                           posts_counter: 1)
      @user2 = User.create(name: "Vanel", photo: "https://fastly.picsum.photos/id/108/200/200.jpg?hmac=JbZfKLS2wWv420Eq9HSIstvyiTaniwUcJjhDeOdwc88", bio: "Software-Engineer",
                           posts_counter: 1)
      @post = Post.create(title: "Machine Learning", text: "First post", comments_counter: 2, likes_counter: 1, author: @user1)
      @first_comment = Comment.create(text: "First comment", author: @user1, post: @post)
      @second_comment = Comment.create(text: "Second comment", author: @user2, post: @post)
      Like.create(author: @user1, post: @post)
      visit user_post_path(user_id: @user1.id, id: @post.id)
    end

    it "should render the post's title" do
      expect(page).to have_content(@post.title)
    end

    it "should render who wrote the post" do
      expect(page).to have_content(@post.author.name)
    end

    it "should render how many comments it has" do
      expect(page).to have_content(@post.comments_counter)
    end

    it "should render how many likes it has" do
      expect(page).to have_content(@post.likes_counter)
    end

    it "should render the post body" do
      expect(page).to have_content(@post.text)
    end

    it "should render the username of each commentor" do
      expect(page).to have_content(@user1.name)
      expect(page).to have_content(@user2.name)
    end

    it "should render the comment each commentor left" do
      expect(page).to have_content(@first_comment.text)
      expect(page).to have_content(@second_comment.text)
    end
  end
end
