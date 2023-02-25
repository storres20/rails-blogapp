require_relative './rails_helper'

RSpec.describe Post, type: :model do
  subject do
    Post.new(title: 'AI', text: 'Great post', comments_counter: 1, likes_counter: 1,
             author_id: 7)
  end

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should be AI' do
    expect(subject.title).to eql 'AI'
  end

  it 'title should be maximum 250 words' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'text should be valid' do
    expect(subject.text).to eql 'Great post'
  end

  it 'comments counter should be present' do
    subject.comments_counter = nil
    expect(subject).to_not be_valid
  end

  it 'comments counter should be valid' do
    expect(subject.comments_counter).to eql 1
  end

  it 'comments counter should be greater than or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'comments counter should be integer' do
    subject.comments_counter = 1.1
    expect(subject).to_not be_valid
  end

  it 'likes counter should be present' do
    subject.likes_counter = nil
    expect(subject).to_not be_valid
  end

  it 'likes counter should be valid' do
    expect(subject.likes_counter).to eql 1
  end

  it 'likes counter should be greater than or equal to 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes counter should be integer' do
    subject.likes_counter = 1.1
    expect(subject).to_not be_valid
  end

  it 'should return the 3 most recent comments for a given post' do
    expect(subject.recent_comments).to eq(subject.comments.order(created_at: :desc).limit(5))
  end
end
