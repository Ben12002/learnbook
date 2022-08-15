class PostsController < ApplicationController

  def index
    if current_user.friends.length > 0
      @posts = get_recent_friends_posts
    else
      @posts = get_recent_posts
    end
  end

  def new
    @current_user.build
  end

  def show
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def get_recent_friends_posts
  end

  def get_recent_posts
  end
end
