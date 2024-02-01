class Public::NotificationsController < ApplicationController
  
  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end
  
  def read
    notification = current_user.notifications.find(params[:id])
    unless notification.read?
      notification.update(read: ture)
    end
    redirect_to notifications_path
  end
  
  def transition_path(notification)
    case notification.action_type
    when :commented_to_own_post
      post_music_path(notification.subject.post_music, anchor: "comment-#{notification.subject.id}")
    when :favorited_to_own_post
      post_music_path(notification.subject.post_music)
    when :followed_me
      user_path(notification.subject.follower)
    end
  end
  
end





