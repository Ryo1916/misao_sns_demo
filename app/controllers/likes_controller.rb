class LikesController < ApplicationController
  before_action :authenticate_user!
  # respond_to :js, :json, :html

  def create
    @like = Like.create(user_id: current_user.id, post_id: params[:post_id])
    # @likes = Like.where(post_id: params[:post_id])
    # @posts = Post.all
    respond_to do |format|
      format.html { redirect_to @like }
      format.js
    end

    # @like = Like.new(like_params)
    # @like.save
    # respond_to do |format|
    #   format.html
    #   format.js { render json: { status: "success" } }
    # end

  # using class method in post.rb version
    # @post = Post.find(params[:post_id])
    # current_user.like(@post)
    # respond_to do |format|
    #   format.html { redirect_to @post }
    #   format.js
    # end

  # normal version
    # @like = Like.new(user_id: current_user.id, post_id: params[:post_id])
    # @like.save
    # respond_to do |format|
    #   format.html { redirect_to posts_path }
    #   format.js
    # end
  end

    # if request.path_info == "/posts"
      # redirect_to posts_path
    # end

    # if request.path_info == "/users/#{@like.post.user.id}"
    #   redirect_to request.path_info
    # end

  def destroy
    like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    like.destroy
    # @likes = Like.where(post_id: params[:post_id])
    # @posts = Post.all
    respond_to do |format|
      format.html { redirect_to like }
      format.js
    end

    # @like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    # @like.destroy
    # respond_to do |format|
    #   format.html
    #   format.js
    # end

    # like = current_user.likes.find_by(post_id: @post.id)
    # like.destory

  end

  private

  def set_variables
    @post = Post.find(params[:post_id])
    @id_name = "like-link-#{@post.id}"
    @id_heart = "#heart-#{@post.id}"
  end

  # def like_params
  #   params.require(:like).permit(:user_id, :post_id)
  # end

end
