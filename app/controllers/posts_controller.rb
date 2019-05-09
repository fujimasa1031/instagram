class PostsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_post, only: %i(show destroy)

  def new
    @post = Post.new
    @post.photos.new
  end

  def create
    @post = Post.new(post_params)
    if @post.photos.present?
      @post.save
      flash[:notice] = 'Create new post!!'
      redirect_to root_path
    else
      flash[:alert] = 'Miss your post...'
      redirect_to new_post_path
    end
  end

  def index
    @posts = Post.limit(10).includes(:photos, :user).order('created_at desc')
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.user == current_user
      flash[:notice] = "Delete the post" if @post.destroy
    else
      flash[:alert] = "Missed Delete..."
    end
    redirect_to root_path
  end

  private
    def post_params
      params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
    end

end
