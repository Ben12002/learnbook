class NotificationsController < ApplicationController

  def index
    @notifications = current_user.received_notifications

    @notifications.each do |notification|
      notification.set_to_seen
    end
  end
end
