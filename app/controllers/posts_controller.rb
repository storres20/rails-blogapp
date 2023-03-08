class PostsController < ApplicationController
  def index
    @user = User.includes([:posts]).find(params[:user_id])
    @posts = @user.posts.includes([:comments]).order(created_at: :asc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      flash[:notice] = 'Post created successfully'
      redirect_to user_posts_path(current_user)
    else
      flash[:alert] = "Couln't create post"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @like = Like.new
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
