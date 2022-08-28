class FriendshipsController < ApplicationController

  def index
    @user = current_user
    @received_friend_requests = @user.received_friend_requests
    @sent_friend_requests = @user.sent_friend_requests
    @friends = @user.friends
    @users = User.all - @friends - @sent_friend_requests - @received_friend_requests - [current_user]
  end

  def create
    Friendship.create(sender_id: current_user.id, receiver_id: params[:receiver_id])
    redirect_to friendships_path
  end

  def update
    @friend_request = Friendship.find(params[:id])
    @friend_request.update(pending: false)
    Friendship.destroy_requests_after_accept(@friend_request.sender_id, @friend_request.receiver_id)
    redirect_to friendships_path
  end

  def destroy
    Friendship.destroy(params[:id])
    redirect_to friendships_path
  end
end
