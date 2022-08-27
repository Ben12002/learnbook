class LikesController < ApplicationController

  def create
    current_user.likes.create(likeable_id: params[:likeable_id], likeable_type: params[:likeable_type])
    
    # Stand in until I get redirect_back to work
    if params[:likeable_type] == "Post"
      post = Post.find(params[:likeable_id])
      link = post_path(params[:likeable_id])
      type = :like_post
      Notification.create_and_send(current_user, post.creator, type, link)
      redirect_to post
    else
      comment = Comment.find(params[:likeable_id])
      link = post_comments_path(comment.commentable_id, comment.id)
      type = :like_comment
      Notification.create_and_send(current_user, comment.creator, type, link)
      redirect_to comment.commentable
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
