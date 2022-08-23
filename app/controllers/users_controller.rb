class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find(params[:id])
    @profile = @user.profile
    # @post = @user.created_posts
    # @comments = @user.created_comments
    # @friends = @user.friends
  end
end
