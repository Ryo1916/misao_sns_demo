class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = if params[:search]
      Post.where(user_id: params[:id]).where('content LIKE ?', "%#{params[:search]}%").order(id: :desc)
    else
      Post.where(user_id: params[:id]).order(id: :desc)
    end
    @likes = Like.where(user_id: params[:id]).order(id: :desc)
  end

  def index
    @users = if params[:search]
      User.where('name LIKE ?', "%#{params[:search]}%")
    else
      User.all
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
end
