class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_auth

  # GET /posts
  # GET /posts.json
  def index
    @post = Post.new
    @posts = if params[:search]
      Post.where(user_id: current_user.following).where('content LIKE ?', "%#{params[:search]}%").order(updated_at: :desc)
    else
    # when you want to display all posts, use the below line after remove '#'.
      # Post.all.order(id: :desc)
    # when display posts of followings user, use the below line
      following_ids = "SELECT followed_id FROM relationships WHERE follower_id = #{current_user.id}"
      Post.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: current_user.id).order(updated_at: :desc)
    end

  # when you want to display all users in "you may also like", use below line.
    # @users = User.all
  # when you want to display friends of friends(followers of followers) in "you may also like", use below line.
    @followings = current_user.following    # followers of current user
    @temps = Array.new
    @followings.each do |friend|
      friend.following.each do |fof|
        if fof != current_user              # except currnet user
          @temps << fof                     # assign friends of friends to @temps
        end
      end
      @temps.uniq                           # eliminate duplication from @temps
    end
    @fofs = @temps - @followings            # eliminate duplication from @followings

  # Display comments and comment form
    @comment = Comment.new

  # if you want to display location info as a google map, use below lines
    # @posts.each do |f|
    #   @hash = Gmaps4rails.build_markers(f) do |post, marker|
    #     marker.lat post.latitude
    #     marker.lng post.longitude
    #     marker.infowindow post.address
    #   end
    # end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    # @hash = Gmaps4rails.build_markers(@post) do |post, marker|
    #   marker.lat post.latitude
    #   marker.lng post.longitude
    #   marker.infowindow post.address
    # end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    if current_user.id != @post.user_id
      # flash[:notice] = "You cannot access this page."
      redirect_to post_path
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
        format.json { render :index, status: :created, location: @post }
      else
        format.html { render :index }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :image_name, :user_id, :latitude, :longitude, :address, :likes_count)
    end

    def set_auth
      @auth = session[:omniauth] if session[:omniauth]
    end
end
