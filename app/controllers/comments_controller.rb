class CommentsController < ApplicationController
 
  def new
    @post = Post.find(params[:post_id])
    # @new_top_comment = @post.comments.build(creator_id: current_user.id)
    if params[:parent_id]
      @replied_comment_id = params[:parent_id] 
      # @new_comment = @post.comments.build(creator_id: current_user.id, parent_id: @replied_comment_id)
      render "post/show"
    else
      redirect_to @post
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(creator_id: current_user.id, parent_id: comment_params[:parent_id], body: comment_params[:body])

    if @comment.save
      flash[:notice] = "Successfully commented"
    else
      flash[:alert] = "Failed to comment"
    end

    redirect_to @post
  end

  def edit
    @post = Post.find(params[:post_id])
  end

  def update
  end

  def destroy
  end

  private
  
  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
