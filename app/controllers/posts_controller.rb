class PostsController < ApplicationController

  def index
    # if current_user.friends.length > 0
    #   @posts = get_recent_friends_posts
    # else
    #   @posts = get_recent_posts
    # end

    if params[:user_id] # users/posts
      @user = User.find(params[:user_id])
      @posts = @user.created_posts
      render "users/posts"
    else # posts
      @posts = Post.all 
    end
  end

  def show
    @post = Post.find(params[:id])
    @parent_id = nil

    # Instead of this, I moved it to _comment_form.html.erb so that a new instance is automatically instantiated
    # whenever the form is rendered, rather than separately having it in both posts and comments controller.
    # @comment = Comment.new

    # Don't do this. This instantiates an extra comment under a post. Don't tie the comment to the Post yet, even if you're not saving it yet.
    # @comment = @post.comments.build(creator_id: current_user.id)
  end

  def new
    @post = Post.new(creator_id: current_user.id)
  end

  def create
    @post = current_user.created_posts.build(post_params)
    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path
  end

  private

  def get_recent_friends_posts
  end

  def get_recent_posts
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
