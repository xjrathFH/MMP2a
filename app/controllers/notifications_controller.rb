# frozen_string_literal: true

# Notifications Controller
class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def mark_as_read
    @notification = Notification.find(params[:id])
    @notification.update(read: true)
    head :no_content
  end
end
