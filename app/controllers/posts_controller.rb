class PostsController < ApplicationController

  def index
    # if current_user.friends.length > 0
    #   @posts = get_recent_friends_posts
    # else
    #   @posts = get_recent_posts
    # end
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    # This instantiates an extra comment under a post. Don't tie the comment to the Post yet, even if you're not saving it yet.
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

    if @article.update(article_params)
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
