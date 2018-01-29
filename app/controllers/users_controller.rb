class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: params[:id]).order(id: :desc)
    @likes = Like.where(user_id: params[:id]).order(id: :desc)
  end
end
