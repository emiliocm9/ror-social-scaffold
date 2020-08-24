class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
    user_posts
    friend_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    @timeline_posts ||= Post.all.ordered_by_most_recent.includes(:user)
  end

  def user_posts
    @user_posts ||= current_user.posts.includes(:user)
  end

  def friend_posts
    friends = current_user.friends.pluck(:id)
    @friend_posts ||= Post.where(user_id: friends).ordered_by_most_recent
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
