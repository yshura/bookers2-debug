class RelationshipsController < ApplicationController
  def create
    current_user.follow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
     @users = user.followers
  end

  def follow_list
    user = User.find(params[:user_id])
    @users = user.followings
  end
  
  def follower_list
     user = User.find(params[:user_id])
     @users = user.followers
  end
end
