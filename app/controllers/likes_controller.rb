class LikesController < ApplicationController
  before_action :authenticate_user!
  respond_to :js, :json, :html

  def create
    @post = Post.find(params[:post_id])
    unless @post.like?(current_user)
      @like = Like.create(user_id: current_user.id, post_id: params[:post_id])
      @post.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || posts_path }
        format.js
      end
    end

  # success ver(using class methods)
    # @post = Post.find(params[:post_id])
    # unless @post.like?(current_user)
    #   @post.like(current_user)
    #   @post.reload
    #   respond_to do |format|
    #     format.html { redirect_to request.referrer || posts_path }
    #     format.js
    #   end
    # end
  end

  def destroy
    @post = Like.find(params[:id]).post
    if @post.like?(current_user)
      like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
      like.destroy
      @post.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || posts_path }
        format.js
      end
    end

  # success ver(using class methods)
    # @post = Like.find(params[:id]).post
    # if @post.like?(current_user)
    #   @post.unlike(current_user)
    #   @post.reload
    #   respond_to do |format|
    #     format.html { redirect_to request.referrer || posts_path }
    #     format.js
    #   end
    # end
  end

end
