class LikesController < ApplicationController

  def create
    current_user.likes.create(likeable_id: params[:likeable_id], likeable_type: params[:likeable_type])
    
    # Stand in until I get redirect_back to work
    if params[:likeable_type] == "Post"
      redirect_to Post.find(params[:likeable_id])
    else
      redirect_to Comment.find(params[:likeable_id]).commentable
    end
  end

  def destroy
    current_user.likes.where(likeable_id: params[:likeable_id], likeable_type: params[:likeable_type]).destroy_all
    
    # Stand in until I get redirect_back to work
    if params[:likeable_type] == "Post"
      redirect_to Post.find(params[:likeable_id])
    else
      redirect_to Comment.find(params[:likeable_id]).commentable
    end
  end
end
