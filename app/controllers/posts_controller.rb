class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # skip_before_action :forbid_login_user

  # GET /posts
  # GET /posts.json
  def index
    @post = Post.new
    @posts = Post.all.order(id: :desc)
    @users = User.all

    # @posts.each do |f|
    #   @hash = Gmaps4rails.build_markers(f) do |post, marker|
    #     marker.lat post.latitude
    #     marker.lng post.longitude
    #     marker.infowindow post.address
    #   end
    # end

    # @posts.each do |post|
    #   @likes_count = Like.where(post_id: post.id).count
    # end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    # @hash = Gmaps4rails.build_markers(@post) do |post, marker|
    #   marker.lat post.latitude
    #   marker.lng post.longitude
    #   marker.infowindow post.address
    # end
    if current_user.id != @post.user_id
      # flash[:notice] = "You cannot access this page."
      redirect_to posts_path
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    if current_user.id != @post.user_id
      # flash[:notice] = "You cannot access this page."
      redirect_to posts_path
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
        # format.json { render :show, status: :created, location: @post }
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
      params.require(:post).permit(:content, :image_name, :user_id, :latitude, :longitude, :address)
    end
end
