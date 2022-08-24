class DislikesController < ApplicationController

  def create
    current_user.dislikes.create(dislikeable_id: params[:dislikeable_id], dislikeable_type: params[:dislikeable_type])
    
    # Stand in until I get redirect_back to work
    if params[:dislikeable_type] == "Post"
      redirect_to Post.find(params[:dislikeable_id])
    else
      redirect_to Comment.find(params[:dislikeable_id]).commentable
    end
  end

  def destroy
    current_user.dislikes.where(dislikeable_id: params[:dislikeable_id], dislikeable_type: params[:dislikeable_type]).destroy_all
    
    # Stand in until I get redirect_back to work
    if params[:dislikeable_type] == "Post"
      redirect_to Post.find(params[:dislikeable_id])
    else
      redirect_to Comment.find(params[:dislikeable_id]).commentable
    end
  end

end
