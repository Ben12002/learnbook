class CommentsController < ApplicationController
 
  
  def index
    # Accessed from /user/comments
    @user = User.find(params[:user_id])
    @comments = @user.created_comments
    render "users/comments"
  end

  def show
    @post = Post.find(params[:post_id])
    redirect_to @post
  end
  
  def new
    @post = Post.find(params[:post_id])

    if params[:parent_id]
      @parent_id = params[:parent_id]
    else
      @parent_id = nil
    end 
    render "posts/show"
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(creator_id: current_user.id, parent_id: comment_params[:parent_id], body: comment_params[:body])

    if @comment.save
      flash[:notice] = "Successfully commented"

      # the form submit includes a parameter :parent_id. If this parameter is set to nil,
      # it is converted to an "" in the controller, which is TRUTHY
      type = comment_params[:parent_id] == "" ? :comment : :replied_comment

      link = post_path(params[:post_id])
      Notification.create_and_send(current_user, @post.creator, type, link)
    else
      flash[:alert] = "Failed to comment"
    end

    redirect_to @post
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @parent_id = @comment.parent_id
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to @post
  end

  private
  
  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
