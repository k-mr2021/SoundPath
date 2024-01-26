class Public::NotificationsController < ApplicationController
  
  def index
      @notificstions = current_user.notifications.order(created_at: :desc)
      if @notifications.present?
        @notifications.where(checked: false).each do |notification|
          notification.update(checked: true)
        end
      end
  end
end

