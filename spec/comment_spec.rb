require_relative './rails_helper'

RSpec.describe Comment, type: :model do
  user = User.create(name: 'Bob', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher', posts_counter: 0)
  post = Post.create(title: 'Bio', text: 'Amazing post', comments_counter: 0, likes_counter: 0, author: user)
  subject { Comment.new(text: 'Hi', author: user, post:) }

  before { subject.save }

  it 'comments counter should be 1' do
    expect(post.comments_counter).to eq 1
  end

  it 'should not valid without an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'should not valid without a post' do
    subject.post = nil
    expect(subject).to_not be_valid
  end
end
