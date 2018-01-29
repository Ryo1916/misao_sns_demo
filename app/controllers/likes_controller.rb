class LikesController < ApplicationController
  before_action :authenticate_user!
  respond_to :js, :json, :html

  def create
    @like = Like.new(user_id: current_user.id, post_id: params[:like][:post_id])
    @like.save
    respond_to do |format|
      format.html { redirect_to }
      format.js
    end

    # respond_to do |format|
    #   format.html {}
    #   format.json { render js: { :status => "success" } }
    # end
  end

    # if request.path_info == "/posts"
      # redirect_to posts_path
    # end

    # if request.path_info == "/users/#{@like.post.user.id}"
    #   redirect_to request.path_info
    # end

  def destroy
    @like = Like.find_by(user_id: current_user.id, post_id: params[:like][:post_id])
    @like.destroy
    respond_to do |format|
      format.html { redirect_to }
      format.js
    end

    # respond_to do |format|
    #   format.html {}
    #   format.json { render js: { :status => "success" } }
    # end
  end

end
