class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def update
    notification = current_user.notifications.find_by(id: params[:id])

    if notification
      notification.update(read: true)
      case notification.notifiable_type
      when "Book"
        redirect_to book_path(notification.notifiable)
      else
        redirect_to user_path(notification.notifiable&.user || notifications_path)
      end
    else
      redirect_to notifications_path, alert: "通知が見つかりません"
    end
  end
end
