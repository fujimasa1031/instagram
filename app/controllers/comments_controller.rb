class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @post = @comment.post

    if @comment.save
      respond_to :js
    else
      flash[:alert] = "Missed comment..."
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post

    if @comment.destroy
      respond_to :js
    else
      flash[:alert] = "Missed delete comment..."
    end
  end

  private
    def comment_params
      params.required(:comment).permit(:user_id, :post_id, :comment)
    end
end
