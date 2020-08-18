class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:id])
    current_user.request_friend(@user)
    redirect_to users_path(@user)
    flash[:notice] = 'Success'
  end

  def show
    redirect_to users_path
  end  

  def update
    @user = User.find(params[:user_id])
    @friendship = @user.friendships.find(params[:id])
    @friendship.accept
  end

  def destroy
    @user = User.find(params[:user_id])
    @friendship = @user.friendships.find(params[:id])
    @friendship.decline
  end
end