class SharesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_share, only: [:destroy]

  # POST /shares
  # POST /shares.json
  def create
    post = Post.find(params[:post_id])
    Share.create(user_id: current_user.id, post_id: post.id)
    Post.find(post.id).update_attribute(:updated_at, Time.now)
    redirect_to posts_path
  end

  # DELETE /shares/1
  # DELETE /shares/1.json
  def destroy
    @share.destroy
    redirect_to posts_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_share
      @share = Share.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def share_params
      params.require(:share).permit(:user_id, :post_id)
    end
end
